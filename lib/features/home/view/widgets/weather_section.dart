import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/features/home/model/weather_model.dart';
import 'package:growiq/features/home/view_model/weather_cubit.dart';
import 'package:growiq/features/home/view_model/weather_state.dart';
import 'package:lottie/lottie.dart';
import 'weather_info_widget.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class WeatherSection extends StatelessWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<WeatherCubit>(),
      child: BlocBuilder<WeatherCubit, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading || state is WeatherInitial) {
            return _buildLoadingCard();
          }
          Weather? currentWeather;
          if (state is WeatherSuccess) {
            currentWeather = state.weather;
          }
          return _buildWeatherCard(context, currentWeather);
        },
      ),
    );
  }

  Widget _buildWeatherCard(BuildContext context, Weather? weather) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.transparentWhite10,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.transparentWhite05),
      ),
      child: Row(
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
              temperature: weather != null
                  ? "${weather.temperature.toInt()}°"
                  : "--",
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: WeatherInfoWidget(
              condition: AppLocalizations.of(context)!.humidity,
              temperature: weather != null ? "${weather.humidity}%" : "--",
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: WeatherInfoWidget(
              condition: AppLocalizations.of(context)!.windSpeed,
              temperature: weather != null ? "${weather.windSpeed} km/h" : "--",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 60,
            height: 80,
            child: Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          ...List.generate(
            3,
            (_) => Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 12,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColors.white24,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      height: 10,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.white12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
