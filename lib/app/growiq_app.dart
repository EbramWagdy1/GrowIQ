
import 'package:flutter/material.dart';
import 'package:growiq/core/routing/app_router.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/home/view_model/device_cubit.dart';
import 'package:growiq/core/services/service_locator.dart';

class GrowIQ extends StatelessWidget {
  const GrowIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DeviceCubit>(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: AppStrings.appName,
        routerConfig: AppRouter.router,
        theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: AppColors.backgroundColor,

          appBarTheme: AppBarTheme(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: Colors.black),
            titleTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
