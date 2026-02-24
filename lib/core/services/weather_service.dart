import 'dart:convert';
import 'package:growiq/features/home/model/weather_model.dart';
import 'package:http/http.dart' as http;


class WeatherService {
  static const String apiKey = '';
  static const String baseUrl = 'https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline';

  Future<Weather> fetchWeather(String location) async {
    final url = '$baseUrl/$location?unitGroup=metric&include=current&key=$apiKey&contentType=json';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data['currentConditions']);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}