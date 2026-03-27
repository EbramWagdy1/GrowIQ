import 'package:flutter/material.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/me/view/widgets/profile_menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/theme/theme_cubit.dart';
import 'package:growiq/core/theme/theme_state.dart';
import 'package:growiq/core/l10n/locale_cubit.dart';
import 'package:growiq/core/l10n/locale_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.settings),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return Center(
                  child: Column(
                    children: [
                      ProfileMenuItem(
                        text: AppLocalizations.of(context)!.darkMode,
                        icon: Icons.dark_mode_outlined,
                        trailing: Switch(
                          value: Theme.of(context).brightness == Brightness.dark,
                          onChanged: (val) {
                            context.read<ThemeCubit>().updateThemeMode(
                              val ? ThemeMode.dark : ThemeMode.light,
                            );
                          },
                          activeThumbColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      ProfileMenuItem(
                        text: AppLocalizations.of(context)!.notifications,
                        icon: Icons.notifications_outlined,
                        trailing: Switch(
                          value: false,
                          onChanged: (val) {},
                          activeThumbColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      // Language selector
                      ProfileMenuItem(
                        text: AppLocalizations.of(context)!.language,
                        icon: Icons.language,
                        trailing: BlocBuilder<LocaleCubit, LocaleState>(
                          builder: (context, localeState) {
                            final langCode = localeState.locale?.languageCode ?? Localizations.localeOf(context).languageCode;
                            final langText = langCode == 'ar'
                                ? AppLocalizations.of(context)!.arabic
                                : AppLocalizations.of(context)!.english;
                            return Text(langText);
                          },
                        ),
                        onTap: () async {
                          final selected = await showDialog<String>(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: Text(AppLocalizations.of(context)!.language),
                              children: [
                                SimpleDialogOption(
                                  onPressed: () => Navigator.pop(context, 'en'),
                                  child: Text(AppLocalizations.of(context)!.english),
                                ),
                                SimpleDialogOption(
                                  onPressed: () => Navigator.pop(context, 'ar'),
                                  child: Text(AppLocalizations.of(context)!.arabic),
                                ),
                              ],
                            ),
                          );
                          if (selected != null) {
                            context.read<LocaleCubit>().changeLocale(selected);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
