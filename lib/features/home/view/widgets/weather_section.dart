import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/features/home/model/weather_model.dart';
import 'package:growiq/features/home/view_model/weather_cubit.dart';
import 'package:growiq/features/home/view_model/weather_state.dart';
import 'package:lottie/lottie.dart';
import 'weather_info_widget.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<WeatherCubit>(),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          Weather? currentWeather;
          if (state is WeatherSuccess) {
            currentWeather = state.weather;
          }
          return _buildWeatherCard(currentWeather);
        },
      ),
    );
  }

  Widget _buildWeatherCard(Weather? weather) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    SizedBox(
      width: 60,
      height: 80,
      child: Lottie.asset(Assets.lottieWeather),
    ),
    const SizedBox(width: 5),
    Expanded(
      child: WeatherInfoWidget(
        condition: weather?.description ?? "--",
        temperature: weather != null ? "${weather.temperature.toInt()}°" : "--",
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      
      child: WeatherInfoWidget(
        condition: "Humidity",
        temperature: weather != null ? "${weather.humidity}%" : "--",
      ),
    ),
    const SizedBox(width: 5),
    Expanded(
      child: WeatherInfoWidget(
        condition: "Wind Speed",
        temperature: weather != null ? "${weather.windSpeed} km/h" : "--",
      ),
    ),
  ],
),
    );
  }
}
