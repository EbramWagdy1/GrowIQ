import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ChatWelcomeContent extends StatelessWidget {
  const ChatWelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.welcomeMessage,
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.primaryColor, fontSize: 18),
          ),
        ),
        const SizedBox(height: 18),
        _buildLangButton(context, AppLocalizations.of(context)!.arabic, true),
        const SizedBox(height: 10),
        _buildLangButton(context, AppLocalizations.of(context)!.english, false),
      ],
    );
  }

  Widget _buildLangButton(BuildContext context, String label, bool primary) {
    const Color primaryTeal = AppColors.primaryColor;
    return GestureDetector(
      onTap: () => context.read<ChatCubit>().sendMessage(label, context: context),
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
