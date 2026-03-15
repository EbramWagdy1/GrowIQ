import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';

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
              "Didn't receive any code? ",
              style: AppTextStyles.bodyText1(context).copyWith(fontSize: 14),
            ),
            GestureDetector(
              onTap: canResend ? onResend : null,
              child: Text(
                "Resend Again",
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
          "Request new code in 00:${secondsRemaining.toString().padLeft(2, '0')}s",
          style: AppTextStyles.bodyText1(context).copyWith(fontSize: 14),
        ),
      ],
    );
  }
}