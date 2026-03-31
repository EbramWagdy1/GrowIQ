import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/notification_model.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  StreamSubscription? _notificationsSubscription;
  StreamSubscription? _authSubscription;

  NotificationCubit() : super(NotificationInitial()) {
    _init();
  }

  void _init() {
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        startListening(user.uid);
      } else {
        _notificationsSubscription?.cancel();
        emit(const NotificationLoaded([]));
      }
    });
  }

  void startListening(String uid) {
    _notificationsSubscription?.cancel();
    
    _notificationsSubscription = FirebaseDatabase.instance
        .ref()
        .child('users')
        .child(uid)
        .child('notifications')
        .orderByChild('timestamp')
        .onValue
        .listen((event) {
      if (!isClosed) {
        if (event.snapshot.value == null) {
          emit(const NotificationLoaded([]));
          return;
        }

        try {
          final Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
          final List<NotificationModel> notifications = [];
          
          data.forEach((key, value) {
            notifications.add(NotificationModel.fromJson(Map<String, dynamic>.from(value)));
          });

          notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp));
          emit(NotificationLoaded(notifications));
        } catch (e) {
          emit(NotificationError(e.toString()));
        }
      }
    });
  }

  Future<void> addNotification(NotificationModel notification) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final ref = FirebaseDatabase.instance
            .ref()
            .child('users')
            .child(user.uid)
            .child('notifications')
            .push();
        
        await ref.set(notification.copyWith(id: ref.key).toJson());
      } catch (e) {
        debugPrint("Error saving notification to Firebase: $e");
      }
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _notificationsSubscription?.cancel();
    return super.close();
  }

  Future<void> markAsRead(String notificationId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user.uid)
          .child('notifications')
          .child(notificationId)
          .update({'isRead': true});
    }
  }

  Future<void> clearAll() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(user.uid)
          .child('notifications')
          .remove();
    }
  }
}
