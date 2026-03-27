import 'package:growiq/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

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

List<OnBoardingModel> getOnBoardingData(BuildContext context) {
  return [
  OnBoardingModel(
    image:Assets.imagesOnboarding1,
    title: AppLocalizations.of(context)!.onboardingTitle1,
    desc: AppLocalizations.of(context)!.onboardingDesc1,
  ),
  OnBoardingModel(
    image: Assets.imagesOnboarding2,
    title: AppLocalizations.of(context)!.onboardingTitle2,
    desc: AppLocalizations.of(context)!.onboardingDesc2,
  ),
  OnBoardingModel(
    image: Assets.imagesOnboarding3,
    title: AppLocalizations.of(context)!.onboardingTitle3,
    desc: AppLocalizations.of(context)!.onboardingDesc3,
  ),
  ];
}