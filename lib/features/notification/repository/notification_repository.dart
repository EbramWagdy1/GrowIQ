import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import '../model/notification_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationRepository {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<NotificationModel>> getNotificationsStream(String userId) {
    return _database
        .ref('users/$userId/notifications')
        .orderByChild('timestamp')
        .limitToLast(50)
        .onValue
        .map((event) {
      if (event.snapshot.value == null) return [];
      
      final Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
      final List<NotificationModel> notifications = [];
      
      data.forEach((key, value) {
        notifications.add(NotificationModel.fromJson(Map<String, dynamic>.from(value)));
      });

      notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      return notifications;
    });
  }

  Future<void> saveNotification(NotificationModel notification) async {
    final user = _auth.currentUser;
    if (user != null) {
      final ref = _database
          .ref('users/${user.uid}/notifications')
          .push();
      
      await ref.set(notification.copyWith(id: ref.key).toJson());
    }
  }

  Future<void> markAsRead(String userId, String notificationId) async {
    await _database
        .ref('users/$userId/notifications/$notificationId')
        .update({'isRead': true});
  }

  Future<void> clearAll(String userId) async {
    await _database
        .ref('users/$userId/notifications')
        .remove();
  }
}
