import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:growiq/core/utils/sensor_utils.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class DeviceModel extends Equatable {
  final String id;
  final String name;
  final bool isOnline;
  final String ownerId;
  final Map<String, dynamic> sensors;
  final Map<String, dynamic> actuators;
  final Map<String, dynamic> modes;
  final Map<String, dynamic> ai;
  final Map<String, dynamic> thresholds;

  const DeviceModel({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.ownerId,
    this.sensors = const {},
    this.actuators = const {},
    this.modes = const {},
    this.ai = const {},
    this.thresholds = const {},
  });

  bool get isHealthy => ai['disease']?.toString().toLowerCase() == 'healthy';
  
  String getAiDiseaseMessage(BuildContext context) => isHealthy 
      ? AppLocalizations.of(context)!.farmIsHealthy 
      : '${AppLocalizations.of(context)!.issueDetected}: ${ai['disease'] ?? 'Unknown'}';
      
  String getAiConfidenceMessage(BuildContext context) => isHealthy 
      ? AppLocalizations.of(context)!.systemsRunningOptimally 
      : '${AppLocalizations.of(context)!.aiConfidence}: ${(double.tryParse(ai['confidence']?.toString() ?? '0.0') ?? 0.0).toStringAsFixed(1)}%';
      
  bool get isAiMode => modes['ai_mode'] == true || modes['ai_mode'] == 1 || modes['ai_mode'] == '1';
  
  Color get statusColor => isOnline ? Colors.green : Colors.red;

  String getModeName(BuildContext context) => isAiMode 
      ? AppLocalizations.of(context)!.aiModeActive 
      : AppLocalizations.of(context)!.manualMode;

  String getOnlineStatusString(BuildContext context) => isOnline 
      ? 'Online' 
      : AppLocalizations.of(context)!.deviceOffline;

  List<String> get displaySensorKeys => SensorUtils.getSortedSensorKeys(sensors);
  factory DeviceModel.fromMap(String id, Map<dynamic, dynamic> map) {
    final String name = map['name'] ?? map['deviceId'] ?? 'Farm $id';
    
    final dynamic isOnlineRaw = map['isOnline'];
    final bool isOnline = isOnlineRaw is bool 
        ? isOnlineRaw 
        : (isOnlineRaw is String ? isOnlineRaw.toLowerCase() == 'true' : true);
        
    final String ownerId = map['ownerId'] ?? '';

    final Map<String, dynamic> sensors = {};
    map.forEach((key, value) {
      if (key != 'name' &&
          key != 'isOnline' &&
          key != 'ownerId' &&
          key != 'deviceId' &&
          key != 'sensors' &&
          key != 'actuators' &&
          key != 'modes' &&
          key != 'ai' &&
          key != 'thresholds') {
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
      modes: Map<String, dynamic>.from(map['modes'] ?? {}),
      ai: Map<String, dynamic>.from(map['ai'] ?? {}),
      thresholds: Map<String, dynamic>.from(map['thresholds'] ?? {}),
    );
  }

  DeviceModel copyWith({
    String? name,
    bool? isOnline,
    String? ownerId,
    Map<String, dynamic>? sensors,
    Map<String, dynamic>? actuators,
    Map<String, dynamic>? modes,
    Map<String, dynamic>? ai,
    Map<String, dynamic>? thresholds,
  }) {
    return DeviceModel(
      id: id,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
      ownerId: ownerId ?? this.ownerId,
      sensors: sensors ?? this.sensors,
      actuators: actuators ?? this.actuators,
      modes: modes ?? this.modes,
      ai: ai ?? this.ai,
      thresholds: thresholds ?? this.thresholds,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    isOnline,
    ownerId,
    sensors,
    actuators,
    modes,
    ai,
    thresholds,
  ];
}
