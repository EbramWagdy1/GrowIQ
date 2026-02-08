import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/utils/app_text_style.dart' hide AppColors;
import 'package:growiq/feauters/home/presentation/widgets/Weather_Section.dart';

class HomeBar extends StatelessWidget {
  const HomeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primaryColor,
      padding: const EdgeInsets.all(16),
    
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(Assets.imagesOnboarding1),
              ),
              title: Text(
                AppStrings.welcome,
                style: AppTextStyles.hintText.copyWith(
                  color: Colors.white70,
                ),
              ),
              subtitle: Text(
                "Ebram Wagdy",
                style: AppTextStyles.buttonText.copyWith(
                  color: Colors.white,
                ),
              ),
              trailing: SvgPicture.asset(
                Assets.svgsQr,
                color: Colors.white,
              ),
            ),
    
            const SizedBox(height: 20),
    
            // 2. The Weather Widget
            const WeatherSection(),
          ],
        ),
      ),
    );
  }
}
