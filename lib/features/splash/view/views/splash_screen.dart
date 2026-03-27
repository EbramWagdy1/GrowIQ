import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/core/database/cache/cache_helper.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/utils/app_assets.dart';

import 'package:lottie/lottie.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _startAnimation = false;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      if (mounted) setState(() => _startAnimation = true);
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      final bool isFirstTime =
          getIt<CacheHelper>().getData(key: 'isFirstTime') ?? false;
      if (!isFirstTime) {
        context.go('/onBoarding');
      } else if (FirebaseAuth.instance.currentUser != null) {
        context.go('/Home');
      } else {
        context.go('/Login');
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
                color: Theme.of(context).colorScheme.primary,
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
                color: Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RepaintBoundary(
                  child: Lottie.asset(
                    Assets.lottieLogo,
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                    addRepaintBoundary:
                        false, // Using manual wrapper above to ensure it doesn't leak bounds
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.appNamed,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.splashSubtitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
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
