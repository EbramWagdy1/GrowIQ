import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'core/routing/app_router.dart';
void main() {
    runApp(const GrowIQ());
}

class GrowIQ extends StatelessWidget {
  const GrowIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme:ThemeData(
        useMaterial3: false,
        scaffoldBackgroundColor: AppColors.backgroundColor
      ),
      title: AppStrings.appName,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      
    );
  }
}
