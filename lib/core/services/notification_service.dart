import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;
import 'dart:io' show Platform;
import 'package:growiq/core/database/cache/cache_helper.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/control/view_model/device_cubit.dart';
import '../../features/control/view_model/device_state.dart';
import '../utils/notification_mapper.dart';
import '../services/notification_local_storage.dart';
import '../../features/notification/model/notification_model.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications = FlutterLocalNotificationsPlugin();

  // Channels for Android
  static final AndroidNotificationChannel _criticalChannel = AndroidNotificationChannel(
    'critical_channel',
    'Critical Tasks',
    description: 'Used for important plant alerts like water level or device offline.',
    importance: Importance.max,
    playSound: true,
  );

  static final AndroidNotificationChannel _generalChannel = AndroidNotificationChannel(
    'general_channel',
    'General Updates',
    description: 'Used for plant care tips, weather, and AI predictions.',
    importance: Importance.defaultImportance,
  );

  Future<void> init() async {
    // 1. Request permissions
    await _requestPermissions();

    // 2. Setup Local Notifications for Android
    if (!kIsWeb && Platform.isAndroid) {
      await _localNotifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_criticalChannel);
      await _localNotifications
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(_generalChannel);
    }

    // 3. Initialize Local Notifications
    final initializationSettings = InitializationSettings(
      android: const AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: const DarwinInitializationSettings(),
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        _handleNotificationClick(details.payload);
      },
    );

    // 4. Handle FCM messages (foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showLocalNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleNotificationClick(message.data['id']);
    });

    // 5. Subscribe to global topics
    await subscribeToTopic('all_users');
    await subscribeToTopic('weather_alerts');

    // 6. Save FCM Token to Realtime Database (token only — no notification history)
    _fcm.onTokenRefresh.listen((newToken) async {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(user.uid)
            .child('fcmTokens')
            .child(newToken)
            .set(true);
      }
    });

    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        await uploadFcmToken();
        await updateTopicSubscriptions();
      }
    });
  }

  Future<void> uploadFcmToken() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final token = await getToken();
      if (token != null) {
        final cacheHelper = getIt<CacheHelper>();
        final String langCode = cacheHelper.getData(key: 'locale') ?? 'en';
        final bool isEnabled = cacheHelper.getData(key: 'notifications_enabled') ?? true;
        
        await FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(user.uid)
            .update({
              'fcmTokens/$token': true,
              'language': langCode,
              'notificationsEnabled': isEnabled,
            });
        debugPrint("Token, Language and Preference uploaded to DB for user ${user.uid}");
      }
    }
  }

  Future<void> updateTopicSubscriptions() async {
    final cacheHelper = getIt<CacheHelper>();
    final bool isEnabled = cacheHelper.getData(key: 'notifications_enabled') ?? true;
    
    if (isEnabled) {
      await subscribeToTopic('all_users');
      await subscribeToTopic('weather_alerts');
    } else {
      await unsubscribeFromTopic('all_users');
      await unsubscribeFromTopic('weather_alerts');
    }
  }

  Future<void> _requestPermissions() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future<String?> getToken() async {
    try {
      if (kIsWeb) {
        return await _fcm.getToken(
          vapidKey: "WG8QUoz_UwSqd-cMLOaYQRyB-TQyLTiXLWpvyLJQZV8",
        );
      }
      return await _fcm.getToken();
    } catch (e) {
      debugPrint("Error getting token: $e");
      return null;
    }
  }

  // 🔹 Topic Subscription
  Future<void> subscribeToTopic(String topic) async {
    await _fcm.subscribeToTopic(topic);
    debugPrint("Subscribed to topic: $topic");
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    await _fcm.unsubscribeFromTopic(topic);
    debugPrint("Unsubscribed from topic: $topic");
  }

  void _showLocalNotification(RemoteMessage message) async {
    // 1. Get current locale
    final cacheHelper = getIt<CacheHelper>();
    final String langCode = cacheHelper.getData(key: 'locale') ?? 'en';
    final locale = Locale(langCode);

    // 2. Check if notifications are enabled
    final bool isEnabled = cacheHelper.getData(key: 'notifications_enabled') ?? true;
    if (!isEnabled) {
      debugPrint("[NotificationService] Notifications disabled by user. Skipping.");
      return;
    }

    // 3. Load translations
    final l10n = await AppLocalizations.delegate.load(locale);

    // 4. Extract data from FCM payload
    final String type = message.data['type'] ?? 'Informational';
    final String id = message.data['id'] ?? 'notification';
    final String? deviceId = message.data['deviceId'] ?? message.data['farmId'];
    final String deviceName = message.data['deviceName'] ?? '';

    // 🔹 GHOST DEVICE FILTER
    if (deviceId != null && deviceId.isNotEmpty) {
      try {
        final deviceCubit = getIt<DeviceCubit>();
        final state = deviceCubit.state;
        if (state is DeviceUpdated) {
          final ownsDevice = state.devices.any((d) => d.id == deviceId);
          if (!ownsDevice) {
            debugPrint("[NotificationService] Blocked ghost notification for unowned device: $deviceId");
            return;
          }
        }
      } catch (e) {
        debugPrint("[NotificationService] Error validating device ownership: $e");
      }
    }

    // 5. Build title & body
    String title = message.notification?.title ?? NotificationMapper.getTranslatedTitle(type, l10n);
    String body = message.notification?.body ?? NotificationMapper.getTranslatedBody(id, l10n);

    // 6. Select Channel
    String channelId = _generalChannel.id;
    if (type == 'Critical') channelId = _criticalChannel.id;

    title = _formatTitle(title);
    body = _formatBody(body);

    // ✅ PERSIST LOCALLY (Hive) — no Firebase write!
    final notif = NotificationModel(
      id: id,
      title: title,
      body: body,
      timestamp: DateTime.now(),
      type: type,
      isRead: false,
      deviceId: deviceId,
      deviceName: deviceName.isNotEmpty ? deviceName : null,
    );
    await NotificationLocalStorage.add(notif);

    // 7. Show the visual notification
    _localNotifications.show(
      message.hashCode,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          _getChannelName(channelId, l10n),
          importance: channelId == _criticalChannel.id ? Importance.max : Importance.defaultImportance,
          priority: channelId == _criticalChannel.id ? Priority.max : Priority.defaultPriority,
          icon: '@mipmap/ic_launcher',
          largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
          color: const Color(0xFF004D40),
          styleInformation: BigTextStyleInformation(
            body,
            contentTitle: title,
          ),
        ),
      ),
      payload: id,
    );
  }

  static String _formatTitle(String title) {
    if (title.isEmpty || title == 'notification') return 'Notification';
    return title;
  }
  
  static String _formatBody(String body) {
    if (body.contains('_')) {
      return body.split('_').map((word) {
        if (word.isEmpty) return '';
        return word[0].toUpperCase() + word.substring(1).toLowerCase();
      }).join(' ');
    }
    return body;
  }

  static String _getChannelName(String channelId, AppLocalizations l10n) {
    if (channelId == _criticalChannel.id) return l10n.notificationCritical;
    return l10n.notificationInformational;
  }

  void _handleNotificationClick(String? id) {
    if (id != null) {
      debugPrint("Notification clicked with ID: $id");
      // Add navigation logic here
    }
  }

  @pragma('vm:entry-point')
  static Future<void> showBackgroundNotification(RemoteMessage message) async {
    // 🔹 PREVENT EMPTY/GHOST NOTIFICATIONS
    if (message.notification == null || message.data['deviceId'] == null) {
      debugPrint("[BG] Ghost notification ignored (missing notification payload or deviceId).");
      return;
    }

    // 🔹 PREVENT DUPLICATE NOTIFICATION
    debugPrint("[BG] Message has notification block — OS will display it. Persisting locally.");

    try {
      await Firebase.initializeApp();
      final prefs = await SharedPreferences.getInstance();

      final bool isEnabled = prefs.getBool('notifications_enabled') ?? true;
      if (!isEnabled) return;

      final String type = message.data['type'] ?? 'Informational';
      final String id = message.data['id'] ?? 'notification';
      final String? deviceId = message.data['deviceId'];
      final String deviceName = message.data['deviceName'] ?? '';

      final String langCode = prefs.getString('locale') ?? 'en';
      final locale = Locale(langCode);
      final l10n = await AppLocalizations.delegate.load(locale);

      String title = message.notification?.title ?? NotificationMapper.getTranslatedTitle(type, l10n);
      String body = message.notification?.body ?? NotificationMapper.getTranslatedBody(id, l10n);
      title = _formatTitle(title);
      body = _formatBody(body);

      // ✅ PERSIST LOCALLY (Hive) — safe in background isolate
      await NotificationLocalStorage.init(); // Ensure Hive is open in background isolate
      final notif = NotificationModel(
        id: id,
        title: title,
        body: body,
        timestamp: DateTime.now(),
        type: type,
        isRead: false,
        deviceId: deviceId,
        deviceName: deviceName.isNotEmpty ? deviceName : null,
      );
      await NotificationLocalStorage.add(notif);
      debugPrint('[BG] Notification persisted locally: $type');

    } catch (e) {
      debugPrint("[BG] Error in background notification handler: $e");
    }
  }
}
