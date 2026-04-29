import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/device_model.dart';
import '../repository/device_repository.dart';
import '../../../core/services/auth_service.dart';
import 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  final DeviceRepository _repository;
  final AuthService _authService;

  // Real-time subscriptions management
  StreamSubscription<List<String>>? _deviceIdsSubscription;
  StreamSubscription<User?>? _authSubscription;
  final Map<String, StreamSubscription<DeviceModel?>> _deviceSubscriptions = {};

  // Offline-detection: one timer per device
  final Map<String, Timer> _offlineTimers = {};
  static const Duration _offlineThreshold = Duration(seconds: 15);

  // Current state data
  final Map<String, DeviceModel> _devicesMap = {};
  int _selectedDeviceIndex = 0;

  DeviceCubit(this._repository, this._authService) : super(DeviceInitial()) {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _authSubscription = _authService.authStateChanges.listen((user) {
      if (user != null) {
        _initUserDevicesListener(user.uid);
      } else {
        _clearAllSubscriptions();
        emit(DeviceInitial());
      }
    });
  }

  void _initUserDevicesListener(String userId) {
    emit(DeviceLoading());

    // 🕒 Safety Timeout
    Future.delayed(const Duration(seconds: 5), () {
      if (state is DeviceLoading) {
        emit(const DeviceUpdated([]));
      }
    });

    _deviceIdsSubscription?.cancel();
    _deviceIdsSubscription = _repository
        .getDeviceIdsStream(userId)
        .listen(
          (deviceIds) {
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
    _deviceSubscriptions[deviceId] = _repository.getDeviceStream(deviceId).listen((
      device,
    ) {
      if (device != null) {
        _devicesMap[deviceId] = device;
        // ✅ Reset offline timer on every real data update
        _resetOfflineTimer(deviceId);
      } else {
        _devicesMap.remove(deviceId);
        _cancelOfflineTimer(deviceId);
      }
      _emitUpdatedState();
    });
  }

  /// Resets the 1-minute inactivity timer for [deviceId].
  void _resetOfflineTimer(String deviceId) {
    _cancelOfflineTimer(deviceId);
    _offlineTimers[deviceId] = Timer(_offlineThreshold, () async {
      // Mark the device offline in Firebase after 15 seconds of silence
      try {
        await _repository.updateOnlineStatus(deviceId, false);
      } catch (_) {}
    });
  }

  void _cancelOfflineTimer(String deviceId) {
    _offlineTimers[deviceId]?.cancel();
    _offlineTimers.remove(deviceId);
  }

  void _emitUpdatedState() {
    final sortedDevices = _devicesMap.values.toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    
    // Ensure index is valid after list updates
    if (_selectedDeviceIndex >= sortedDevices.length) {
      _selectedDeviceIndex = 0;
    }
    
    emit(DeviceUpdated(sortedDevices, selectedDeviceIndex: _selectedDeviceIndex));
  }

  void selectDevice(int index) {
    _selectedDeviceIndex = index;
    _emitUpdatedState();
  }

  Future<void> addDevice(String deviceId) async {
    final user = _authService.currentUser;
    if (user == null) {
      emit(const DeviceError("User not logged in"));
      return;
    }

    // Basic validation
    if (_isInvalidDeviceId(deviceId)) {
      emit(
        const DeviceError(
          "Invalid QR Code FORMAT: Must be a valid MAC Address / Farm ID",
        ),
      );
      return;
    }

    try {
      emit(DeviceLoading());

      final deviceData = await _repository.getDeviceData(deviceId);
      if (deviceData == null) {
        emit(const DeviceError("Device not found"));
        _emitUpdatedState();
        return;
      }

      final ownerId = deviceData['ownerId'] ?? '';
      if (ownerId != '' && ownerId != user.uid) {
        emit(const DeviceError("Device already owned by another user"));
        _emitUpdatedState();
        return;
      }

      await _repository.claimDevice(deviceId, user.uid);
      emit(DeviceAddSuccess(deviceId));
    } catch (e) {
      emit(DeviceError(e.toString()));
      _emitUpdatedState();
    }
  }

  Future<void> setCropType(
    String deviceId,
    Map<String, Map<String, double>> thresholds, {
    String? plantType,
  }) async {
    try {
      await _repository.updateCropType(deviceId, thresholds, plantType: plantType);
      _emitUpdatedState(); // Refresh UI after saving crop thresholds
    } catch (e) {
      emit(DeviceError("Failed to set crop type: ${e.toString()}"));
      _emitUpdatedState();
    }
  }

  bool _isInvalidDeviceId(String deviceId) {
    return deviceId.contains('.') ||
        deviceId.contains('#') ||
        deviceId.contains('\$') ||
        deviceId.contains('[') ||
        deviceId.contains(']') ||
        deviceId.contains('/');
  }

  Future<void> renameDevice(String deviceId, String newName) async {
    try {
      await _repository.renameDevice(deviceId, newName);
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
      await _repository.updateActuator(deviceId, actuator, value);
    } catch (e) {
      emit(DeviceError("Failed to toggle $actuator: ${e.toString()}"));
      _emitUpdatedState();
    }
  }

  Future<void> toggleMode(String deviceId, String modeName, bool value) async {
    try {
      await _repository.updateMode(deviceId, modeName, value);
    } catch (e) {
      emit(DeviceError("Failed to toggle $modeName: ${e.toString()}"));
      _emitUpdatedState();
    }
  }

  Future<void> removeDevice(String deviceId) async {
    final user = _authService.currentUser;
    if (user == null) return;

    try {
      emit(DeviceLoading());
      await _repository.unclaimDevice(deviceId, user.uid);
    } catch (e) {
      emit(DeviceError("Failed to remove device: ${e.toString()}"));
      _emitUpdatedState();
    }
  }

  void refresh() {
    final user = _authService.currentUser;
    if (user != null) {
      _initUserDevicesListener(user.uid);
    }
  }

  void _clearDeviceSubscriptions() {
    for (var sub in _deviceSubscriptions.values) {
      sub.cancel();
    }
    _deviceSubscriptions.clear();

    // Cancel all offline timers
    for (var t in _offlineTimers.values) {
      t.cancel();
    }
    _offlineTimers.clear();

    _devicesMap.clear();
  }

  void _clearAllSubscriptions() {
    _deviceIdsSubscription?.cancel();
    _clearDeviceSubscriptions();
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    _clearAllSubscriptions();
    return super.close();
  }
}
