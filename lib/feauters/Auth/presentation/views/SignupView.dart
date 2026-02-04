import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/custom_Buttom.dart';
import 'package:growiq/feauters/Auth/presentation/views/auth_form.dart';
import 'package:growiq/feauters/Auth/widgets/CustomTextField.dart';
import 'package:growiq/feauters/Auth/widgets/logo_widget.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Logowidget(text: AppStrings.signupSubtitle),
            ),
            SliverToBoxAdapter(child: CustomTextField(text: AppStrings.name)),
            SliverToBoxAdapter(child: SizedBox(height: 15)),
            SliverToBoxAdapter(child: CustomTextField(text: AppStrings.email)),
            SliverToBoxAdapter(child: SizedBox(height: 15)),
            SliverToBoxAdapter(
              child: CustomTextField(text: AppStrings.password),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: CustomTextField(text: AppStrings.confirmPassword),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 15)),
            SliverToBoxAdapter(
              child: CustomButtom(
                text: AppStrings.signup,
                onPressed: () {
                  customReplacementNavigate(context, '/Home');
                },
              ),
            ),
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
    );
  }
}
