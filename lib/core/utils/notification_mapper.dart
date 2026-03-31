import 'package:growiq/core/l10n/arb/app_localizations.dart';

class NotificationMapper {
  static String getTranslatedTitle(String type, AppLocalizations l10n) {
    switch (type) {
      case 'Critical':
        return l10n.notificationCritical;
      case 'Environmental':
        return l10n.notificationEnvironmental;
      case 'Automation':
        return l10n.notificationAutomation;
      case 'AI':
        return l10n.notificationAI;
      default:
        return l10n.notificationInformational;
    }
  }

  static String getTranslatedBody(String id, AppLocalizations l10n) {
    switch (id) {
      // Critical
      case 'device_offline':
        return l10n.deviceOffline;
      case 'water_tank_empty':
        return l10n.waterTankEmpty;
      case 'power_failure':
        return l10n.powerFailure;
      case 'sensor_failure':
        return l10n.sensorFailure;
      // Environmental
      case 'low_soil_moisture':
        return l10n.lowSoilMoisture;
      case 'high_temperature':
        return l10n.highTemperature;
      case 'low_temperature':
        return l10n.lowTemperature;
      case 'high_humidity':
        return l10n.highHumidity;
      // Automation
      case 'auto_irrigation_started':
        return l10n.autoIrrigationStarted;
      case 'auto_irrigation_stopped':
        return l10n.autoIrrigationStopped;
      case 'fan_activated':
        return l10n.fanActivated;
      case 'grow_light_activated':
        return l10n.growLightActivated;
      // AI
      case 'disease_detected':
        return l10n.diseaseDetected;
      case 'ai_action_taken':
        return l10n.aiActionTaken;
      case 'ai_prediction_alert':
        return l10n.aiPredictionAlert;
      // Informational
      case 'weather_alert':
        return l10n.weatherAlert;
      case 'plant_care_tip':
        return l10n.plantCareTip;
      default:
        return id;
    }
  }
}
