import 'dart:convert';
import '../../../core/database/cache/cache_helper.dart';
import '../../../core/services/weather_service.dart';
import '../model/weather_model.dart';

class WeatherRepository {
  final WeatherService _service;
  final CacheHelper _cacheHelper;
  static const String _weatherCacheKey = 'cached_weather';

  WeatherRepository(this._service, this._cacheHelper);

  Future<Weather> getWeather(String city) async {
    try {
      final weather = await _service.fetchWeather(city);
      // Cache the successful response
      await _cacheHelper.saveData(
        key: _weatherCacheKey,
        value: json.encode(weather.toJson()),
      );
      return weather;
    } catch (e) {
      // Return cached weather as fallback
      final cachedData = _cacheHelper.getData(key: _weatherCacheKey);
      if (cachedData != null) {
        return Weather.fromJson(json.decode(cachedData));
      }
      rethrow;
    }
  }

  Weather? getCachedWeather() {
    final cachedData = _cacheHelper.getData(key: _weatherCacheKey);
    if (cachedData != null) {
      return Weather.fromJson(json.decode(cachedData));
    }
    return null;
  }
}
