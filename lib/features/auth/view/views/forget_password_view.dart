import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forget Password View'),
      ),
      body: const Center(
        child: Text('Welcome to the Forget Password View!'),
      ),
    );
  }
}