
import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:lottie/lottie.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ForgetPasswordHeader extends StatelessWidget {
  const ForgetPasswordHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Lottie.asset(Assets.forgetpass, width: 150, height: 200),
        const SizedBox(width: 15),
        Text(
          AppLocalizations.of(context)!.forgetPasswordTitle,
          style: AppTextStyles.titleMedium(context).copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
