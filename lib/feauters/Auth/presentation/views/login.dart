import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/widgets/custom_Buttom.dart';
import 'package:growiq/feauters/Auth/presentation/views/auth_form.dart';
import 'package:growiq/feauters/Auth/widgets/CustomTextField.dart';
import 'package:growiq/feauters/Auth/widgets/logo_widget.dart';

class Loginview extends StatelessWidget {
  const Loginview({super.key});

  @override
  Widget build(BuildContext context) {
    return Login();
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Logowidget(text: AppStrings.loginSubtitle),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: CustomTextFormField(text: AppStrings.email)),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: CustomTextFormField(text: AppStrings.password),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: CustomButtom(
                text: AppStrings.login,
                onPressed: () {
                  customReplacementNavigate(context, '/Home');
                },
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  customNavigate(context, "/ForgetPasswordView");
                },
                child: Center(
                  child: Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyles.bodyText1,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Autform(
                text: "or login",
                questionText: AppStrings.dontHaveAccount,
                createAccountText: "Create Account",
                path: "/Signup",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
