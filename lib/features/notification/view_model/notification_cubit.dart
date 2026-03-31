import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/notification_model.dart';
import '../repository/notification_repository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final NotificationRepository _repository;
  StreamSubscription? _notificationsSubscription;
  StreamSubscription? _authSubscription;

  NotificationCubit(this._repository) : super(NotificationInitial()) {
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
    _notificationsSubscription = _repository.getNotificationsStream(uid).listen((notifications) {
      if (!isClosed) {
        emit(NotificationLoaded(notifications));
      }
    }, onError: (e) {
      if (!isClosed) emit(NotificationError(e.toString()));
    });
  }

  Future<void> addNotification(NotificationModel notification) async {
    await saveToFirebase(notification);
  }

  /// Centralized static method to save notifications, safe for background isolates.
  static Future<void> saveToFirebase(NotificationModel notification) async {
    try {
      // In background handlers, we can't always rely on getIt,
      // so we use a fresh instance if needed, or better, the Repository handles its own instance
      await NotificationRepository().saveNotification(notification);
      debugPrint("Notification saved via Repository");
    } catch (e) {
      debugPrint("Error saving notification: $e");
    }
  }

  Future<void> markAsRead(String notificationId) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _repository.markAsRead(user.uid, notificationId);
    }
  }

  Future<void> clearAll() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _repository.clearAll(user.uid);
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _notificationsSubscription?.cancel();
    return super.close();
  }
}
