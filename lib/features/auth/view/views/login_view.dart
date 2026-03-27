import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/features/auth/view/views/auth_form.dart';
import 'package:growiq/features/auth/view/widgets/custom_login_form.dart';
import 'package:growiq/features/auth/view/widgets/logo_widget.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

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
                child: Logowidget(text: AppLocalizations.of(context)!.loginSubtitle),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(child: CustomLoginForm()),
              SliverToBoxAdapter(child: SizedBox(height: 20)),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () {
                    customNavigate(context, "/forget-password");
                  },
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.forgotPassword,
                      style: AppTextStyles.bodyText1(context).copyWith(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Autform(
                  text: AppLocalizations.of(context)!.orLogin,
                  questionText: AppLocalizations.of(context)!.dontHaveAccount,
                  createAccountText: AppLocalizations.of(context)!.createAccount,
                  path: "/Signup",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
