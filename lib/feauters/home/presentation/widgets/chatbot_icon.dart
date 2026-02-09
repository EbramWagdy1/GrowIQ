import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:lottie/lottie.dart';

class Chatboticon extends StatelessWidget {
  const Chatboticon({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        customNavigate(context, '/chatbot');
      },
      child: Container(
        alignment: Alignment.bottomRight,
        child: Lottie.asset(
          Assets.lottieLivechatbot,
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
