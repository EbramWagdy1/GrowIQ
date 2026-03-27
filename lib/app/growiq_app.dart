
import 'package:flutter/material.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import 'package:growiq/core/routing/app_router.dart';
import 'package:growiq/core/l10n/locale_cubit.dart';
import 'package:growiq/core/l10n/locale_state.dart';

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
        BlocProvider(create: (context) => getIt<LocaleCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return BlocBuilder<LocaleCubit, LocaleState>(
            builder: (context, localeState) {
              return MaterialApp.router(
                locale: localeState.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                debugShowCheckedModeBanner: false,
                onGenerateTitle: (context) => AppLocalizations.of(context)!.appName,
                routerConfig: AppRouter.router,
                themeMode: themeState.themeMode,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
              );
            },
          );
        },
      ),
    );
  }
}
