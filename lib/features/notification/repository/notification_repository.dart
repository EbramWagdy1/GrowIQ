import 'package:growiq/core/services/notification_local_storage.dart';
import '../model/notification_model.dart';

/// 📬 Notification Repository — Local-first (Hive) implementation.
///
/// All reads/writes go to on-device Hive storage.
/// Firebase RTDB is no longer used for notifications — this eliminates
/// the 21GB/month download usage caused by onValue real-time streams.
///
/// Notifications arrive via FCM push (server → device).
/// The app persists them here when received.
class NotificationRepository {
  /// Reads all locally stored notifications (newest first).
  /// Auto-purges entries older than 7 days.
  List<NotificationModel> getNotifications() {
    return NotificationLocalStorage.getAll();
  }

  /// Saves a new notification to local Hive storage.
  /// Deduplicates within a 1-minute window per type+device.
  Future<void> saveNotification(NotificationModel notification) async {
    await NotificationLocalStorage.add(notification);
  }

  /// Marks a single notification as read.
  Future<void> markAsRead(String notificationId) async {
    await NotificationLocalStorage.markAsRead(notificationId);
  }

  /// Marks all notifications as read.
  Future<void> markAllAsRead() async {
    await NotificationLocalStorage.markAllAsRead();
  }

  /// Deletes all local notifications.
  Future<void> clearAll() async {
    await NotificationLocalStorage.clearAll();
  }

  /// Returns count of unread notifications (useful for badge).
  int getUnreadCount() {
    return NotificationLocalStorage.getUnreadCount();
  }
}
