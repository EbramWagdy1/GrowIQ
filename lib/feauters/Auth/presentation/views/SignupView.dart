import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/feauters/Auth/presentation/views/auth_form.dart';
import 'package:growiq/feauters/Auth/widgets/CustomSignupForm.dart';
import 'package:growiq/feauters/Auth/widgets/logo_widget.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Logowidget(text: AppStrings.signupSubtitle),
              ),
              SliverToBoxAdapter(child: CustomSignupForm()),
              SliverToBoxAdapter(
                child: Autform(
                  text: "or signup",
                  questionText: AppStrings.alreadyHaveAccount,
                  createAccountText: "Login",
                  path: "/Login",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


