import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Customesmoothpageindicator extends StatelessWidget {
  const Customesmoothpageindicator({super.key, required this.controller});
   final PageController controller ;
  @override
  Widget build(BuildContext context) {
    return   SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  activeDotColor: AppColors.secondaryColor,
                  dotWidth: 10,
                  dotHeight: 7,
                ),
              );
  }
}