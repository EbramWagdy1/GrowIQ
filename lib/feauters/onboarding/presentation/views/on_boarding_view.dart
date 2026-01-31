import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/custom_Buttom.dart';
import 'package:growiq/feauters/onboarding/presentation/widgets/custom_navbar.dart';
import 'package:growiq/feauters/onboarding/presentation/widgets/onboardin_body.dart';
class OnBoardingview extends StatelessWidget {
  const OnBoardingview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Removed SafeArea
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            CustomNavbar(),
            const SizedBox(height: 80),
            Onboardingwidgetbody(),
             CustomButtom(text: AppStrings.next),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}