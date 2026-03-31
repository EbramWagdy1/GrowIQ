import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class HomeLoadingView extends StatelessWidget {
  const HomeLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.checkingDevices,
            style: AppTextStyles.bodyText1(context).copyWith(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
