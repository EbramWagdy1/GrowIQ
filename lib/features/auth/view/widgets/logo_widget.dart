import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:lottie/lottie.dart';

class Logowidget extends StatelessWidget {
  const Logowidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(Assets.lottieLogo, width: 150, height: 150),
          Text(
            AppStrings.appNamed,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),),
            SizedBox(height: 10),
             Text(
            text ,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ), 
          ),
           
        ],
      ),
    );
  }
}