import 'package:flutter/material.dart';

class SensorUtils {
  // =========================
  // Sensor Icons
  // =========================
  static IconData getSensorIcon(String sensorName) {
    switch (sensorName.toLowerCase()) {
      // 🌡️ Air Temperature
      case 'DHT 22':
      case 'air temperature':
      case 'airtemperature':
      case 'temperature':
      case 'Temperature':
        return Icons.thermostat;

      // 💧 Air Humidity
      case 'air humidity':
      case 'airhumidity':
      case 'humidity':
      case 'Humidity':
      return Icons.water_drop;

      // 🌱 Soil Moisture
      case 'capacitive soil moisture sensor':
      case 'soil moisture':
      case 'soilmoisture':
        return Icons.grass;

      // 🌡️ Soil Temperature DS18B20
      case 'ds18b20 – soil temperature':
      case 'soil temperature':
        return Icons.thermostat;

      // 💡 Light Level
      case 'ldr':
      case 'light level':
      case 'lightlevel':
        return Icons.light_mode;

      // 🌫️ Air Quality / CO₂ Indicator
      case 'mq-135':
      case 'air quality':
      case 'airquality':
      case 'co2':
      case 'air quality / co₂ indicator':
        return Icons.air;
      
      // 🌊 Water Level
      case 'water level':
      case 'waterlevel':
      case 'liquid level':
        return Icons.waves;

      default:
        return Icons.sensors;
    }
  }

  // =========================
  // Sensor Units
  // =========================
  static String getSensorUnit(String sensorName) {
    final name = sensorName.toLowerCase();

    if (name.contains('temperature')) {
      return '°C';
    }

    if (name.contains('humidity')) {
      return '%RH';
    }

    if (name.contains('soil moisture') ||
        name.contains('capacitive soil moisture')) {
      return '%';
    }

    if (name.contains('light')) {
      return 'Lux';
    }

    if (name.contains('quality') ||
        name.contains('co2') ||
        name.contains('mq-135')) {
      return 'ppm';
    }

    if (name.contains('water level') || name.contains('liquid level')) {
      return '%';
    }

    return '';
  }

  // =========================
  // Actuator Icons
  // =========================
  static IconData getActuatorIcon(String name) {
    switch (name.toLowerCase()) {
      case 'pump':
        return Icons.water_drop;
      case 'light':
        return Icons.lightbulb;
      case 'fan':
        return Icons.air;
      default:
        return Icons.settings_input_component;
    }
  }

  // =========================
  // Sort Sensors
  // =========================
  static const _actuatorKeys = ['pump', 'light', 'fan'];

  /// Returns sensor keys, excluding actuators, sorted by priority:
  /// 1. Soil Temperature first
  /// 2. Humidity second
  /// 3. Everything else alphabetically
  static List<String> getSortedSensorKeys(Map<String, dynamic> sensors) {
    final keys = sensors.keys
        .where((k) => !_actuatorKeys.contains(k.toLowerCase()))
        .toList();

    keys.sort((a, b) {
      final aL = a.toLowerCase();
      final bL = b.toLowerCase();

      if (aL.contains('soil temp') && !bL.contains('soil temp')) return -1;
      if (!aL.contains('soil temp') && bL.contains('soil temp')) return 1;

      if (aL.contains('humidity') && !bL.contains('humidity')) return -1;
      if (!aL.contains('humidity') && bL.contains('humidity')) return 1;

      // 🌊 Water Level last
      final isAWater = aL.contains('water level') || aL.contains('liquid level');
      final isBWater = bL.contains('water level') || bL.contains('liquid level');
      if (isAWater && !isBWater) return 1;
      if (!isAWater && isBWater) return -1;

      return a.compareTo(b);
    });

    return keys;
  }
}
