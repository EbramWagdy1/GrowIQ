class Weather {
  final String description;
  final double temperature;
  final int humidity;
  final double windSpeed;

  Weather({
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final current = json['currentConditions'];
    return Weather(
      description: current['conditions'] ?? "N/A",
      temperature: (current['temp'] as num?)?.toDouble() ?? 0.0,
      humidity: (current['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (current['windspeed'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentConditions': {
        'conditions': description,
        'temp': temperature,
        'humidity': humidity,
        'windspeed': windSpeed,
      }
    };
  }
}