import 'dart:async';
import '../../../core/services/device_service.dart';
import '../model/device_model.dart';

class DeviceRepository {
  final DeviceService _service;

  DeviceRepository(this._service);

  Stream<List<String>> getDeviceIdsStream(String userId) {
    return _service.getDeviceIdsStream(userId);
  }

  Stream<DeviceModel?> getDeviceStream(String deviceId) {
    return _service.getDeviceRawStream(deviceId).map((data) {
      if (data != null) {
        return DeviceModel.fromMap(deviceId, data);
      }
      return null;
    });
  }

  Future<Map<dynamic, dynamic>?> getDeviceData(String deviceId) async {
    return await _service.getDeviceData(deviceId);
  }

  Future<bool> deviceExists(String deviceId) async {
    return await _service.deviceExists(deviceId);
  }

  Future<void> claimDevice(String deviceId, String userId) async {
    await _service.claimDevice(deviceId, userId);
  }

  Future<void> unclaimDevice(String deviceId, String userId) async {
    await _service.unclaimDevice(deviceId, userId);
  }

  Future<void> renameDevice(String deviceId, String newName) async {
    await _service.renameDevice(deviceId, newName);
  }

  Future<void> updateActuator(String deviceId, String actuator, bool value) async {
    await _service.updateActuator(deviceId, actuator, value);
  }

  Future<void> updateMode(String deviceId, String modeName, bool value) async {
    await _service.updateMode(deviceId, modeName, value);
  }

  Future<void> updateCropType(String deviceId, Map<String, Map<String, double>> thresholds) async {
    await _service.updateCropType(deviceId, thresholds);
  }

  Future<void> updateOnlineStatus(String deviceId, bool isOnline) async {
    await _service.updateDeviceOnlineStatus(deviceId, isOnline);
  }
}
