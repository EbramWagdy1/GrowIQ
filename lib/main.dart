import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growiq/app/growiq_app.dart';
import 'package:growiq/core/database/cache/cache_helper.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:growiq/core/services/notification_service.dart';
import 'package:growiq/core/services/notification_local_storage.dart';
import 'package:growiq/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Handling a background message: ${message.messageId}");
  await NotificationService.showBackgroundNotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 🔹 Setup Dependency Injection
  setupServiceLocator();

  // 🔹 Initialize Cache
  await getIt<CacheHelper>().init();

  // 🔹 Initialize Hive (local notification storage)
  await NotificationLocalStorage.init();

  // 🔹 Initialize Notification Service
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await getIt<NotificationService>().init();

  // 🔹 Run App with Connectivity Wrapper
  runApp(const GrowIQ());
}
