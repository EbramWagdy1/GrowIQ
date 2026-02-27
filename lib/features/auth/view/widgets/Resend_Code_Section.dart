import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';

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
            const Text(
              "Didn't receive any code? ",
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
            GestureDetector(
              onTap: canResend ? onResend : null,
              child: Text(
                "Resend Again",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: canResend ? AppColors.secondaryColor : Colors.grey,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Request new code in 00:${secondsRemaining.toString().padLeft(2, '0')}s",
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}