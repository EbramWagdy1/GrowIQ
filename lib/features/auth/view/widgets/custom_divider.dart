import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key , required this.text});
  final String text ;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: AppTextStyles.bodyText1,
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}