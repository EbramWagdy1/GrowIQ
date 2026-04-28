import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:growiq/core/services/notification_local_storage.dart';
import '../model/notification_model.dart';
import '../repository/notification_repository.dart';

part 'notification_state.dart';

/// 🔔 Notification Cubit — Local-first, no Firebase RTDB streams.
///
/// Instead of a persistent Firebase onValue listener (the cause of 21GB/month
/// data usage), this cubit reads from on-device Hive storage.
///
/// Notifications arrive via FCM → NotificationService saves them locally
/// → NotificationCubit.refresh() reloads the list.
class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;

  NotificationCubit(this._repository) : super(NotificationInitial()) {
    // Load on startup when user is already logged in
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      loadNotifications();
    }
  }

  // ─── Load ──────────────────────────────────────────────────────────────────

  /// Reads from local Hive storage and emits [NotificationLoaded].
  void loadNotifications() {
    try {
      final notifications = _repository.getNotifications();
      if (!isClosed) emit(NotificationLoaded(notifications));
    } catch (e) {
      if (!isClosed) emit(NotificationError(e.toString()));
    }
  }

  /// Alias for loadNotifications — called after a new push arrives.
  void refresh() => loadNotifications();

  // ─── Persist ───────────────────────────────────────────────────────────────

  /// Saves an incoming FCM notification to Hive and refreshes the list.
  Future<void> addNotification(NotificationModel notification) async {
    await _repository.saveNotification(notification);
    loadNotifications();
  }

  /// Static variant safe for use inside background FCM isolates.
  static Future<void> saveToLocal(NotificationModel notification) async {
    try {
      await NotificationLocalStorage.add(notification);
      debugPrint('[NotificationCubit] Saved locally in background: ${notification.type}');
    } catch (e) {
      debugPrint('[NotificationCubit] Background save error: $e');
    }
  }

  // ─── Mark as Read ──────────────────────────────────────────────────────────

  Future<void> markAsRead(String notificationId) async {
    await _repository.markAsRead(notificationId);
    loadNotifications();
  }

  Future<void> markAllAsRead() async {
    await _repository.markAllAsRead();
    loadNotifications();
  }

  // ─── Clear ─────────────────────────────────────────────────────────────────

  Future<void> clearAll() async {
    await _repository.clearAll();
    loadNotifications();
  }

  // ─── Unread Badge ──────────────────────────────────────────────────────────

  int get unreadCount => _repository.getUnreadCount();
}
