import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/me/view/widgets/profile_menu_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/theme/theme_cubit.dart';
import 'package:growiq/core/theme/theme_state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.settings),
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
                        text: "Dark Mode",
                        icon: Icons.dark_mode_outlined,
                        trailing: Switch(
                          value:
                              Theme.of(context).brightness == Brightness.dark,
                          onChanged: (val) {
                            context.read<ThemeCubit>().updateThemeMode(
                              val ? ThemeMode.dark : ThemeMode.light,
                            );
                          },
                          // ignore: deprecated_member_use
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      ProfileMenuItem(
                        text: AppStrings.notifications,
                        icon: Icons.notifications_outlined,
                        trailing: Switch(
                          value: false,
                          onChanged: (val) {},
                          // ignore: deprecated_member_use
                          activeColor: Theme.of(context).colorScheme.primary,
                        ),
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
