import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_strings.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String desc;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.desc,
  });
}

List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    image:Assets.imagesOnboarding1,
    title: AppStrings.onboardingTitle1,
    desc: AppStrings.onboardingDesc1,
  ),
  OnBoardingModel(
    image: Assets.imagesOnboarding2,
    title: AppStrings.onboardingTitle2,
    desc: AppStrings.onboardingDesc2,
  ),
  OnBoardingModel(
    image: Assets.imagesOnboarding3,
    title: AppStrings.onboardingTitle3,
    desc: AppStrings.onboardingDesc3,
  ),
];