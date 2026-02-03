import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/widgets/custom_Buttom.dart';
import 'package:growiq/feauters/Auth/widgets/CustomAppLogin.dart';
import 'package:growiq/feauters/Auth/widgets/CustomDivider.dart';
import 'package:growiq/feauters/Auth/widgets/CustomTextField.dart';
import 'package:growiq/feauters/Auth/widgets/logo_widget.dart';

class Loginview extends StatelessWidget {
  const Loginview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(42.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: Logowidget()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Text(AppStrings.login, style: AppTextStyles.titleMedium),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(child: CustomTextField(text: AppStrings.email)),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: CustomTextField(text: AppStrings.password),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: CustomButtom(text: AppStrings.login, onPressed: () {}),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {},
                child: Center(
                  child: Text(
                    AppStrings.forgotPassword,
                    style: AppTextStyles.bodyText1,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(child: CustomDivider()),
            SliverToBoxAdapter(child: SizedBox(height: 40)),
            SliverToBoxAdapter(child: CustomAppLogin()),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  AppStrings.dontHaveAccount,
                  style: AppTextStyles.bodyText1,
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20)),
            SliverToBoxAdapter(
              child: Center(
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Create Account",
                    style: AppTextStyles.bodyText1.copyWith(color: Colors.blue),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
