import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/custom_Buttom.dart';
import 'package:growiq/feauters/onboarding/data/models/on_boarding_model.dart';
import 'package:growiq/feauters/onboarding/presentation/views/functions/onboarding_visit.dart';
import 'package:growiq/feauters/onboarding/presentation/widgets/custom_navbar.dart';
import 'package:growiq/feauters/onboarding/presentation/widgets/onboardin_body.dart';

class OnBoardingview extends StatefulWidget {
  const OnBoardingview({super.key});

  @override
  State<OnBoardingview> createState() => _OnBoardingviewState();
}

class _OnBoardingviewState extends State<OnBoardingview> {
  final PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Removed SafeArea
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            CustomNavbar(),
            const SizedBox(height: 80),
            Onboardingwidgetbody(controller: controller),
            CustomButtom(
              text: AppStrings.next,
              onPressed: () {
               onboardingvisit();
                if (controller.page != null &&
                    controller.page! < onBoardingData.length - 1) {
                  controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  controller.page == onBoardingData.length - 1;
                  customReplacementNavigate(
                    context,
                    '/Login',
                  ); 
                }
              },
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
