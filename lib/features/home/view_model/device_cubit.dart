import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/device_model.dart';
import 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Real-time subscriptions management
  StreamSubscription<DatabaseEvent>? _userDevicesSubscription;
  StreamSubscription<User?>? _authSubscription;
  final Map<String, StreamSubscription<DatabaseEvent>> _deviceSubscriptions =
      {};

  // Current state data
  final Map<String, DeviceModel> _devicesMap = {};

  DeviceCubit() : super(DeviceInitial()) {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authSubscription = _auth.authStateChanges().listen((user) {
      if (user != null) {
        _initUserDevicesListener();
      } else {
        _clearAllSubscriptions();
        emit(DeviceInitial());
      }
    });
  }

  void _initUserDevicesListener() {
    final user = _auth.currentUser;
    if (user == null) {
      emit(const DeviceError("User not authenticated"));
      return;
    }

    emit(DeviceLoading());

    // 🕒 Safety Timeout: If Firebase doesn't respond in 5 seconds, fallback to empty state
    Future.delayed(const Duration(seconds: 5), () {
      if (state is DeviceLoading) {
        emit(const DeviceUpdated([]));
      }
    });

    _userDevicesSubscription?.cancel();

    // Try a direct get() first to catch permission/connection issues quickly
    _database
        .ref('users/${user.uid}/devices')
        .get()
        .then((snapshot) {
          if (!snapshot.exists && state is DeviceLoading) {
            emit(const DeviceUpdated([]));
          }
        })
        .catchError((error) {
          if (state is DeviceLoading) {
            emit(DeviceError("Connection error: ${error.toString()}"));
          }
        });

    _userDevicesSubscription = _database
        .ref('users/${user.uid}/devices')
        .onValue
        .listen(
          (event) {
            final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
            final deviceIds = data.keys.cast<String>().toList();

            if (deviceIds.isEmpty) {
              _clearDeviceSubscriptions();
              emit(const DeviceUpdated([]));
            } else {
              _manageDeviceSubscriptions(deviceIds);
              // Always emit updated state to reflect changes and stop loading
              _emitUpdatedState();
            }
          },
          onError: (error) {
            emit(DeviceError(error.toString()));
          },
        );
  }

  void _manageDeviceSubscriptions(List<String> currentIds) {
    // Remove subscriptions for devices no longer in the list
    final removedIds = _deviceSubscriptions.keys
        .where((id) => !currentIds.contains(id))
        .toList();

    for (var id in removedIds) {
      _deviceSubscriptions[id]?.cancel();
      _deviceSubscriptions.remove(id);
      _devicesMap.remove(id);
    }

    // Add subscriptions for new devices
    for (var id in currentIds) {
      if (!_deviceSubscriptions.containsKey(id)) {
        _listenToDevice(id);
      }
    }
  }

  void _listenToDevice(String deviceId) {
    _deviceSubscriptions[deviceId] = _database
        .ref('farms/$deviceId')
        .onValue
        .listen((event) {
          final data = event.snapshot.value as Map<dynamic, dynamic>?;
          if (data != null) {
            _devicesMap[deviceId] = DeviceModel.fromMap(deviceId, data);
            _emitUpdatedState();
          } else {
            // If device data is missing, we still need to reflect current state
            _devicesMap.remove(deviceId);
            _emitUpdatedState();
          }
        });
  }

  void _emitUpdatedState() {
    final sortedDevices = _devicesMap.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    emit(DeviceUpdated(sortedDevices));
  }

  Future<void> addDevice(String deviceId) async {
    final user = _auth.currentUser;
    if (user == null) {
      emit(const DeviceError("User not logged in"));
      return;
    }

    try {
      emit(DeviceLoading());
      // 1. Check if device exists
      final deviceSnap = await _database.ref('farms/$deviceId').get();
      if (!deviceSnap.exists) {
        emit(const DeviceError("Device not found"));
        // Restore previous state after error
        _emitUpdatedState();
        return;
      }

      final deviceData = deviceSnap.value as Map<dynamic, dynamic>;

      // 2. Check ownership
      final ownerId = deviceData['ownerId'] ?? '';
      if (ownerId != '' && ownerId != user.uid) {
        emit(const DeviceError("Device already owned by another user"));
        _emitUpdatedState();
        return;
      }

      // 3. Claim Device
      await _database.ref().update({
        'farms/$deviceId/ownerId': user.uid,
        'users/${user.uid}/devices/$deviceId': true,
      });

      emit(DeviceAddSuccess());
      // Cubit will automatically update via userDevicesSubscription
    } catch (e) {
      emit(DeviceError(e.toString()));
      _emitUpdatedState();
    }
  }

  Future<void> renameDevice(String deviceId, String newName) async {
    try {
      await _database.ref('farms/$deviceId').update({'name': newName});
      // Updating the farm's name will trigger the listener and refresh the UI automatically
    } catch (e) {
      emit(DeviceError("Failed to rename: ${e.toString()}"));
      _emitUpdatedState();
    }
  }

  Future<void> toggleActuator(
    String deviceId,
    String actuator,
    bool value,
  ) async {
    try {
      await _database.ref('farms/$deviceId').update({actuator: value});
      // Real-time listener will catch the change and update UI
    } catch (e) {
      emit(DeviceError("Failed to toggle $actuator: ${e.toString()}"));
      _emitUpdatedState();
    }
  }

  Future<void> removeDevice(String deviceId) async {
    final user = _auth.currentUser;
    if (user == null) return;

    try {
      emit(DeviceLoading());
      // 1. Remove from user's device list
      await _database.ref('users/${user.uid}/devices/$deviceId').remove();

      // 2. Clear ownerId from the farm record
      await _database.ref('farms/$deviceId/ownerId').set('');

      // Cubit will automatically update via userDevicesSubscription when the ID is removed from user's list
    } catch (e) {
      emit(DeviceError("Failed to remove device: ${e.toString()}"));
      _emitUpdatedState();
    }
  }

  void refresh() {
    _initUserDevicesListener();
  }

  void _clearDeviceSubscriptions() {
    for (var sub in _deviceSubscriptions.values) {
      sub.cancel();
    }
    _deviceSubscriptions.clear();
    _devicesMap.clear();
  }

  void _clearAllSubscriptions() {
    _userDevicesSubscription?.cancel();
    _clearDeviceSubscriptions();
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _clearAllSubscriptions();
    return super.close();
  }
}
