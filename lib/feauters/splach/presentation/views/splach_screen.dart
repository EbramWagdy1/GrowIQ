import 'dart:async';
import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _startAnimation = false;

  @override
  void initState() {
    delayedNavgation(context);
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _startAnimation = true;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutSine,
            top: _startAnimation ? -70 : -250,
            left: _startAnimation ? -70 : -250,
            child: Container(
              width: 200,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOutSine,
            bottom: _startAnimation ? -70 : -300,
            right: _startAnimation ? -70 : -300,
            child: Container(
              width: 200,
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(Assets.lottieLogo, width: 200, height: 200),
                const SizedBox(height: 10),
                Text(
                  AppStrings.appNamed,
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColorPrimary,
                  ),
                  
                ),
                const SizedBox(height: 10),
                  Text(
                  AppStrings.splashSubtitle,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColorPrimary,
                  ),
                  
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

  void delayedNavgation(dynamic context) {
    Future.delayed(const Duration(seconds: 3), () {
      customNavigate(context, '/onBoarding');
    });
  }