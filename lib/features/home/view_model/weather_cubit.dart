import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/services/weather_service.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;
  Timer? _timer;

  WeatherCubit(this.weatherService) : super(WeatherInitial()) {
    _startPeriodicFetch();
  }

  void fetchWeather() async {
    emit(WeatherLoading());
    try {
      final weather = await weatherService.fetchWeather("Cairo,Egypt");
      emit(WeatherSuccess(weather));
    } catch (e) {
      emit(WeatherFailure(e.toString()));
    }
  }

  void _startPeriodicFetch() {
    // Fetch initially
    fetchWeather();

    // Set up periodic fetching (30 minutes)
    _timer = Timer.periodic(const Duration(minutes: 30), (_) {
      fetchWeather();
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
