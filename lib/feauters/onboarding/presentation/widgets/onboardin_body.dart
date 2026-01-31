import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/feauters/onboarding/presentation/widgets/custom_smooth_page.dart';


class Onboardingwidgetbody extends StatelessWidget {
  Onboardingwidgetbody({super.key});
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: controller,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: [
             Container(
              height: 290,
              width: 380 ,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesOnboarding1),
                 fit: BoxFit.fill
                ),
                
              ),
             ),
              const SizedBox(height: 24),
             Customesmoothpageindicator(controller: controller),
              const SizedBox(height: 24),
             Text(
              "Welcome",
              style: AppTextStyles.headlineLarge,
              maxLines: 1,
            ),
              const SizedBox(height: 16),
             Text(
              AppStrings.onboardingTitle1,
              style: AppTextStyles.titleMedium,
              maxLines: 2,
            ),
              const SizedBox(height: 8),
                 Text(
              AppStrings.onboardingDesc1,
              style: AppTextStyles.bodyText1,
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


