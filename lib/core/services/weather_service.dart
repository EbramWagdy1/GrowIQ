import 'dart:convert';
import 'package:growiq/features/home/model/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
final String baseUrl = 'https://my-backend-three-orcin.vercel.app/new-api';
  Future<Weather> fetchWeather(String city) async {
final response = await http.get(Uri.parse('$baseUrl?city=$city'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Weather.fromJson(data);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}