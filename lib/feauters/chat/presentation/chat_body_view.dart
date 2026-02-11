import 'package:flutter/material.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';

class ChatBodyView extends StatelessWidget {
  const ChatBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'chat'),
      body: Center(
       child: Text(" Coming Soon"),
      ),
    );
  }
}