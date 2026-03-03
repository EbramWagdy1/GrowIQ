import 'package:flutter/material.dart';

class SensorUtils {
  // =========================
  // Sensor Icons
  // =========================
  static IconData getSensorIcon(String sensorName) {
    switch (sensorName.toLowerCase()) {
      // 🌡️ Air Temperature
      case 'sht31 – air temperature':
      case 'air temperature':
      case 'airtemperature':
      case 'temperature':
        return Icons.thermostat;

      // 💧 Air Humidity
      case 'sht31 – air humidity':
      case 'air humidity':
      case 'airhumidity':
      case 'humidity':
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

      default:
        return Icons.sensors; 
    }
  }

  // =========================
  // Sensor Units
  // =========================
  static String getSensorUnit(String sensorName) {
    final name = sensorName.toLowerCase();

    if (name.contains('temperature')) return '°C'; 
    if (name.contains('humidity')) return '%RH';
    if (name.contains('soil moisture') || name.contains('capacitive soil moisture')) return '%';
    if (name.contains('light')) return 'Lux';
    if (name.contains('quality') || name.contains('co2') || name.contains('mq-135')) return 'ppm';

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
}