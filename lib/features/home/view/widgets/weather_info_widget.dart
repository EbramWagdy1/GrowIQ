import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_text_style.dart';

class WeatherInfoWidget extends StatelessWidget {
  final String condition;
  final String temperature;

  const WeatherInfoWidget({
    required this.condition,
    required this.temperature,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            condition,
            style: AppTextStyles.hintText.copyWith(
              fontSize: 12,
              color: AppColors.white70,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            temperature,
            style: AppTextStyles.buttonText.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}