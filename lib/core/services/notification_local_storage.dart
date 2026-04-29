import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:growiq/features/notification/model/notification_model.dart';

/// 📦 Local-first notification storage using Hive.
///
/// Why Hive instead of Firebase RTDB?
/// → Eliminates 21GB/month Firebase downloads caused by onValue streams.
/// → Notifications are pushed via FCM, persisted here on-device.
/// → Max 50 entries, auto-purge of entries older than 7 days.
class NotificationLocalStorage {
  static const String _boxName = 'notifications_box';
  static const String _boxKey = 'notifications_list';
  static const int _maxCount = 50;
  static const int _maxAgeDays = 7;

  // ─── Init ────────────────────────────────────────────────────────────────

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<String>(_boxName);
    debugPrint('[NotificationLocalStorage] Hive box opened.');
  }

  static Box<String> get _box => Hive.box<String>(_boxName);

  // ─── Read ─────────────────────────────────────────────────────────────────

  /// Returns all stored notifications, newest first.
  /// Auto-purges entries older than [_maxAgeDays] days on every read.
  static List<NotificationModel> getAll() {
    try {
      final raw = _box.get(_boxKey);
      if (raw == null || raw.isEmpty) return [];

      final List<dynamic> decoded = jsonDecode(raw);
      final cutoff = DateTime.now().subtract(const Duration(days: _maxAgeDays));

      final List<NotificationModel> result = decoded
          .map((e) => NotificationModel.fromJson(Map<String, dynamic>.from(e)))
          .where((n) => n.timestamp.isAfter(cutoff)) // auto-purge old ones
          .toList();

      // Persist back if any were purged
      if (result.length < decoded.length) {
        _persist(result);
        debugPrint(
          '[NotificationLocalStorage] Purged ${decoded.length - result.length} old notifications.',
        );
      }

      return result;
    } catch (e) {
      debugPrint('[NotificationLocalStorage] getAll error: $e');
      return [];
    }
  }

  // ─── Write ────────────────────────────────────────────────────────────────

  /// Prepends a new notification and trims to [_maxCount].
  static Future<void> add(NotificationModel notification) async {
    // 🔹 FAELSAFE: Ignore empty notifications (prevents ghost "إشعار" with no body)
    if (notification.title.trim().isEmpty || notification.body.trim().isEmpty || notification.body.trim() == 'notification') {
      debugPrint('[NotificationLocalStorage] Ignored empty or generic notification.');
      return;
    }

    try {
      final current = getAll();

      // Deduplicate: skip if exact same type+deviceId was added in the last minute
      final oneMinuteAgo = DateTime.now().subtract(const Duration(minutes: 1));
      final isDuplicate = current.any(
        (n) =>
            n.id == notification.id &&
            n.deviceId == notification.deviceId &&
            n.timestamp.isAfter(oneMinuteAgo),
      );
      if (isDuplicate) {
        debugPrint('[NotificationLocalStorage] Duplicate skipped: ${notification.type}');
        return;
      }

      final updated = [notification, ...current];

      // Trim to max
      final trimmed = updated.length > _maxCount
          ? updated.sublist(0, _maxCount)
          : updated;

      await _persist(trimmed);
      debugPrint('[NotificationLocalStorage] Added: ${notification.type} — total: ${trimmed.length}');
    } catch (e) {
      debugPrint('[NotificationLocalStorage] add error: $e');
    }
  }

  // ─── Mark as Read ─────────────────────────────────────────────────────────

  static Future<void> markAsRead(String notificationId) async {
    try {
      final current = getAll();
      final updated = current
          .map((n) => n.id == notificationId ? n.copyWith(isRead: true) : n)
          .toList();
      await _persist(updated);
    } catch (e) {
      debugPrint('[NotificationLocalStorage] markAsRead error: $e');
    }
  }

  static Future<void> markAllAsRead() async {
    try {
      final current = getAll();
      final updated = current.map((n) => n.copyWith(isRead: true)).toList();
      await _persist(updated);
    } catch (e) {
      debugPrint('[NotificationLocalStorage] markAllAsRead error: $e');
    }
  }

  // ─── Clear ────────────────────────────────────────────────────────────────

  static Future<void> clearAll() async {
    try {
      await _box.delete(_boxKey);
      debugPrint('[NotificationLocalStorage] All notifications cleared.');
    } catch (e) {
      debugPrint('[NotificationLocalStorage] clearAll error: $e');
    }
  }

  // ─── Unread Count ─────────────────────────────────────────────────────────

  static int getUnreadCount() {
    return getAll().where((n) => !n.isRead).length;
  }

  // ─── Private ──────────────────────────────────────────────────────────────

  static Future<void> _persist(List<NotificationModel> notifications) async {
    final encoded = jsonEncode(notifications.map((n) => n.toJson()).toList());
    await _box.put(_boxKey, encoded);
  }
}
