import 'package:flutter/material.dart';
import 'package:growiq/features/auth/view/views/auth_form.dart';
import 'package:growiq/features/auth/view/widgets/custom_signup_form.dart';
import 'package:growiq/features/auth/view/widgets/logo_widget.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

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
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Logowidget(text: AppLocalizations.of(context)!.signupSubtitle),
              ),
              SliverToBoxAdapter(child: CustomSignupForm()),
              SliverToBoxAdapter(
                child: Autform(
                  text: AppLocalizations.of(context)!.orSignup,
                  questionText: AppLocalizations.of(context)!.alreadyHaveAccount,
                  createAccountText: AppLocalizations.of(context)!.loginAction,
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
