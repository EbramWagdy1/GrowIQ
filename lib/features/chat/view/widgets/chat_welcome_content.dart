import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';

class ChatWelcomeContent extends StatelessWidget {
  const ChatWelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            "Hello! Welcome to GrowIQ AI",
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xFF004D40), fontSize: 18),
          ),
        ),
        const SizedBox(height: 18),
        _buildLangButton(context, "Arabic", true),
        const SizedBox(height: 10),
        _buildLangButton(context, "English", false),
      ],
    );
  }

  Widget _buildLangButton(BuildContext context, String label, bool primary) {
    const Color primaryTeal = Color(0xFF004D40);
    return GestureDetector(
      onTap: () => context.read<ChatCubit>().sendMessage(label),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: primary ? primaryTeal : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: primaryTeal.withAlpha(40)),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: primary ? Colors.white : primaryTeal,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}