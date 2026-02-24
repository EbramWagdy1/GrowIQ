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
    return Weather(
      description: json['conditions'] ?? "N/A",
      temperature: (json['temp'] as num?)?.toDouble() ?? 0.0,
      humidity: (json['humidity'] as num?)?.toInt() ?? 0,
      windSpeed: (json['windspeed'] as num?)?.toDouble() ?? 0.0,
    );
  }
}