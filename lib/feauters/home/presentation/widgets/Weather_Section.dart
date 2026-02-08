import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/feauters/home/presentation/widgets/weather_info_widget.dart';
import 'package:lottie/lottie.dart';
class WeatherSection extends StatelessWidget {
  const WeatherSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        // ignore: deprecated_member_use
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: Lottie.asset(Assets.lottieWeather),
          ),
          const SizedBox(width: 12),
          const Flexible(
            fit: FlexFit.tight,
            child: WeatherInfoWidget(
              condition: "Partly Cloudy",
              temperature: "23°",
            ),
          ),
          const Flexible(
            fit: FlexFit.tight,
            child: WeatherInfoWidget(
              condition: "Humidity",
              temperature: "67%",
            ),
          ),
          const Flexible(
            fit: FlexFit.tight,
            child: WeatherInfoWidget(
              condition: "Wind Speed",
              temperature: "3.1m/s",
            ),
          ),
        ],
      ),
    );
  }
}
