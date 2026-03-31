import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ResendCodeSection extends StatelessWidget {
  final bool canResend;
  final int secondsRemaining;
  final VoidCallback onResend;

  const ResendCodeSection({
    super.key,
    required this.canResend,
    required this.secondsRemaining,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.didNotReceiveEmail,
              style: AppTextStyles.bodyText1(context).copyWith(fontSize: 14),
            ),
            GestureDetector(
              onTap: canResend ? onResend : null,
              child: Text(
                AppLocalizations.of(context)!.resendAgain,
                style: AppTextStyles.bodyText1(context).copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: canResend ? Theme.of(context).colorScheme.primary : Theme.of(context).disabledColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "${AppLocalizations.of(context)!.requestCodeIn} 00:${secondsRemaining.toString().padLeft(2, '0')}s",
          style: AppTextStyles.bodyText1(context).copyWith(fontSize: 14),
        ),
      ],
    );
  }
}