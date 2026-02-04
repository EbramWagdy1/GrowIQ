import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/feauters/Auth/widgets/CustomAppLogin.dart';
import 'package:growiq/feauters/Auth/widgets/CustomDivider.dart';

class Autform extends StatelessWidget {
  const Autform({super.key, required this.text, required this.questionText, required this.createAccountText, required this.path});
  final String text;
  final String questionText;
  final String createAccountText ;
  final String path ;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        CustomDivider(text: text),
        SizedBox(height: 20),
        CustomAppLogin(),
        SizedBox(height: 20),
        Center(
          child: Text(
            questionText,
            style: AppTextStyles.bodyText1,
          ),
        ),
        SizedBox(height: 15),
        Center(
          child: GestureDetector(
            onTap: () {
              customNavigate(context, path);
            },
            child: Text(
              createAccountText,
              style: AppTextStyles.bodyText1.copyWith(color: Colors.blue),
            ),
          ),
        ),
      ],
    );
  }
}
