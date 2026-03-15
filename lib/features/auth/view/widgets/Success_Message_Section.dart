import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';

class SuccessMessageSection extends StatelessWidget {
  const SuccessMessageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          "Check your Email",
          style: AppTextStyles.bodyText1(context).copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "We've sent you a link to reset your password. Please check your email inbox and follow the instructions to create a new password.",
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