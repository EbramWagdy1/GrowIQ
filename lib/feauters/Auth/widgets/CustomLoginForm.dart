import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/custom_Buttom.dart';
import 'package:growiq/feauters/Auth/widgets/CustomTextField.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Form(child: Column(
      children: [
        CustomTextFormField(text: AppStrings.email),
        SizedBox(height: 15),
        CustomTextFormField(text: AppStrings.password),
        SizedBox(height: 30),
        CustomButtom(
          text: AppStrings.login,
          onPressed: () {
            customNavigate(context, '/Home');
          },
        ),
      ],
    ));
  }
}