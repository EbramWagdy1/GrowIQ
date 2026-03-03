import 'package:equatable/equatable.dart';
class DeviceModel extends Equatable {
  final String id;
  final String name;
  final bool isOnline;
  final String ownerId;
  final Map<String, dynamic> sensors;
  final Map<String, dynamic> actuators;

  const DeviceModel({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.ownerId,
    this.sensors = const {},
    this.actuators = const {},
  });
  factory DeviceModel.fromMap(String id, Map<dynamic, dynamic> map) {
    final String name = map['name'] ?? map['deviceId'] ?? 'Farm $id';
    final bool isOnline = map['isOnline'] ?? true;
    final String ownerId = map['ownerId'] ?? '';

    final Map<String, dynamic> sensors = {};
    map.forEach((key, value) {
      if (key != 'name' &&
          key != 'isOnline' &&
          key != 'ownerId' &&
          key != 'deviceId' &&
          key != 'sensors' &&
          key != 'actuators') {
        sensors[key.toString()] = value;
      }
    });

    if (map['sensors'] != null) {
      sensors.addAll(Map<String, dynamic>.from(map['sensors']));
    }

    return DeviceModel(
      id: id,
      name: name,
      isOnline: isOnline,
      ownerId: ownerId,
      sensors: sensors,
      actuators: Map<String, dynamic>.from(map['actuators'] ?? {}),
    );
  }

  DeviceModel copyWith({
    String? name,
    bool? isOnline,
    String? ownerId,
    Map<String, dynamic>? sensors,
    Map<String, dynamic>? actuators,
  }) {
    return DeviceModel(
      id: id,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
      ownerId: ownerId ?? this.ownerId,
      sensors: sensors ?? this.sensors,
      actuators: actuators ?? this.actuators,
    );
  }

  @override
  List<Object?> get props => [id, name, isOnline, ownerId, sensors, actuators];
}
