import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_strings.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       child: Text(AppStrings.comingSoon),
      ),
    );
  }
}