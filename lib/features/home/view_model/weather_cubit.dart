import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/weather_repository.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _repository;
  Timer? _timer;

  WeatherCubit(this._repository) : super(WeatherInitial()) {
    _init();
  }

  void _init() {
    // 1. Check for cached weather first for instant UI feedback
    final cached = _repository.getCachedWeather();
    if (cached != null) {
      emit(WeatherSuccess(cached));
    }
    
    // 2. Start fetching from network
    _startPeriodicFetch();
  }

  void fetchWeather({bool silent = false}) async {
    // Only show loading if we don't have weather data yet
    if (!silent && state is! WeatherSuccess) {
      emit(WeatherLoading());
    }
    
    try {
      final weather = await _repository.getWeather("Cairo,Egypt");
      emit(WeatherSuccess(weather));
    } catch (e) {
      if (state is! WeatherSuccess) {
        emit(WeatherFailure(e.toString()));
      }
    }
  }

  void _startPeriodicFetch() {
    // Initial network fetch
    fetchWeather(silent: state is WeatherSuccess);

    // Set up periodic fetching (30 minutes)
    _timer = Timer.periodic(const Duration(minutes: 30), (_) {
      fetchWeather(silent: true);
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
