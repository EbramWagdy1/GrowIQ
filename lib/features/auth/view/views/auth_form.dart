import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/features/auth/view/widgets/custom_app_login.dart';
import 'package:growiq/features/auth/view/widgets/custom_divider.dart';

class Autform extends StatelessWidget {
  const Autform({
    super.key,
    required this.text,
    required this.questionText,
    required this.createAccountText,
    required this.path,
  });
  final String text;
  final String questionText;
  final String createAccountText;
  final String path;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CustomDivider(text: text),
        const SizedBox(height: 20),
        const CustomAppLogin(),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(questionText, style: AppTextStyles.bodyText1(context)),
            const SizedBox(width: 5),
            GestureDetector(
              onTap: () {
                customReplacementNavigate(context, path);
              },
              child: Text(
                createAccountText,
                style: AppTextStyles.bodyText1(context).copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
