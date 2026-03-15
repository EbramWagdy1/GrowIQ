
import 'package:flutter/material.dart';
import 'package:growiq/core/routing/app_router.dart';
import 'package:growiq/core/utils/app_strings.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/theme/app_theme.dart';
import 'package:growiq/core/theme/theme_cubit.dart';
import 'package:growiq/core/theme/theme_state.dart';

class GrowIQ extends StatelessWidget {
  const GrowIQ({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<DeviceCubit>()),
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppStrings.appName,
            routerConfig: AppRouter.router,
            themeMode: state.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          );
        },
      ),
    );
  }
}
