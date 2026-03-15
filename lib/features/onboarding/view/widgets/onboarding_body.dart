import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/features/onboarding/model/on_boarding_model.dart';
import 'package:growiq/features/onboarding/view/widgets/custom_smooth_page.dart';


class Onboardingwidgetbody extends StatelessWidget {
  const Onboardingwidgetbody({super.key, required this.controller});
  final PageController controller;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        itemCount: onBoardingData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: 290,
                width: 380,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(onBoardingData[index].image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Customesmoothpageindicator(controller: controller),
              const SizedBox(height: 24),
              Text(AppStrings.welcome, style: AppTextStyles.headlineLarge(context), maxLines: 1),
              const SizedBox(height: 16),
              Text(
                onBoardingData[index].title,
                style: AppTextStyles.titleMedium(context),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Text(
                onBoardingData[index].desc,
                style: AppTextStyles.bodyText1(context),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ],
          );
        },
      ),
    );
  }
}
