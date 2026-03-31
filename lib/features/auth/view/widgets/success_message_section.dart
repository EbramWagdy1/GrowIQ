import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class SuccessMessageSection extends StatelessWidget {
  const SuccessMessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          AppLocalizations.of(context)!.checkYourEmail,
          style: AppTextStyles.bodyText1(context).copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          AppLocalizations.of(context)!.resetEmailSentDesc,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyText1(context).copyWith(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}