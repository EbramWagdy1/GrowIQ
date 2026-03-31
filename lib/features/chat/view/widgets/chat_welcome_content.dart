import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ChatWelcomeContent extends StatelessWidget {
  const ChatWelcomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Center(
          child: Text(
            AppLocalizations.of(context)!.welcomeMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isDarkMode ? Colors.white : AppColors.primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 18),
        _buildLangButton(
            context, AppLocalizations.of(context)!.arabic, true, isDarkMode),
        const SizedBox(height: 10),
        _buildLangButton(
            context, AppLocalizations.of(context)!.english, false, isDarkMode),
      ],
    );
  }

  Widget _buildLangButton(
      BuildContext context, String label, bool primary, bool isDarkMode) {
    final Color primaryTeal = AppColors.primaryColor;

    // Adaptive configuration for buttons
    final Color backgroundColor = primary
        ? (isDarkMode ? Colors.teal[700]! : primaryTeal)
        : (isDarkMode ? Colors.grey[800]! : Colors.white);

    final Color textColor = primary
        ? Colors.white
        : (isDarkMode ? Colors.white : primaryTeal);

    return GestureDetector(
      onTap: () =>
          context.read<ChatCubit>().sendMessage(label, context: context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isDarkMode
                // ignore: deprecated_member_use
                ? Colors.teal.withOpacity(0.3)
                : primaryTeal.withAlpha(40),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
