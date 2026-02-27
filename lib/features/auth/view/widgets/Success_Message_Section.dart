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
          style: AppTextStyles.bodyText1.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "We've sent you a link to reset your password. Please check your email inbox and follow the instructions to create a new password.",
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyText1.copyWith(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}