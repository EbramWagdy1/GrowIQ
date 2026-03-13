import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import '../../features/control/model/device_model.dart';

class DeviceService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  Stream<List<String>> getDeviceIdsStream(String userId) {
    return _database.ref('users/$userId/devices').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>? ?? {};
      return data.keys.cast<String>().toList();
    });
  }

  Stream<DeviceModel?> getDeviceStream(String deviceId) {
    return _database.ref('farms/$deviceId').onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        return DeviceModel.fromMap(deviceId, data);
      }
      return null;
    });
  }

  Future<bool> deviceExists(String deviceId) async {
    final snapshot = await _database.ref('farms/$deviceId').get();
    return snapshot.exists;
  }

  Future<Map<dynamic, dynamic>?> getDeviceData(String deviceId) async {
    final snapshot = await _database.ref('farms/$deviceId').get();
    return snapshot.value as Map<dynamic, dynamic>?;
  }

  Future<void> claimDevice(String deviceId, String userId) async {
    await _database.ref().update({
      'farms/$deviceId/ownerId': userId,
      'users/$userId/devices/$deviceId': true,
    });
  }

  Future<void> unclaimDevice(String deviceId, String userId) async {
    await _database.ref('users/$userId/devices/$deviceId').remove();
    await _database.ref('farms/$deviceId/ownerId').set('');
  }

  Future<void> renameDevice(String deviceId, String newName) async {
    await _database.ref('farms/$deviceId').update({'name': newName});
  }

  Future<void> updateActuator(
    String deviceId,
    String actuator,
    bool value,
  ) async {
    await _database.ref('farms/$deviceId/actuators').update({actuator: value});
  }

  Future<void> updateMode(String deviceId, String modeName, bool value) async {
    await _database.ref('farms/$deviceId/modes').update({modeName: value});
  }

  Future<void> updateCropType(
    String deviceId,
    Map<String, Map<String, double>> thresholds,
  ) async {
    await _database.ref('farms/$deviceId/thresholds').set(thresholds);
  }

  Future<void> updateDeviceOnlineStatus(String deviceId, bool isOnline) async {
    await _database.ref('farms/$deviceId').update({'isOnline': isOnline});
  }
}
