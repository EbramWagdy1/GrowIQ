import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'chat_welcome_content.dart';

class ChatBubble extends StatelessWidget {
  final String content;
  final bool isUser;
  final int index;

  const ChatBubble({
    super.key,
    required this.content,
    required this.isUser,
    required this.index,
  });

  static const Color primaryTeal = AppColors.primaryColor;
  static const Color lightMint = AppColors.lightMint;

  String _formatMarkdown(String text) {
    return text.replaceAllMapped(RegExp(r'(\d+)\.(?!\s)'), (match) {
      return '${match.group(1)}. ';
    });
  }

  TextDirection _getDirection(String text) {
    final bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    return isArabic ? TextDirection.rtl : TextDirection.ltr;
  }

  @override
  Widget build(BuildContext context) {
    bool isWelcome = !isUser && index == 0;
    final currentUser = FirebaseAuth.instance.currentUser;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    // Adaptive Colors
    final Color bubbleColor = isUser
        ? (isDarkMode ? AppColors.primaryColor : lightMint)
        : (isDarkMode ? Colors.grey[850]! : lightMint.withAlpha(200));
        
    final Color textColor = isUser
        ? (isDarkMode ? Colors.white : primaryTeal)
        : (isDarkMode ? Colors.white : primaryTeal);

    final Color secondaryTextColor = isDarkMode ? Colors.tealAccent : AppColors.secondaryColor;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            CircleAvatar(
              radius: 18,
              backgroundColor: isDarkMode ? Colors.grey[800] : AppColors.secondaryColor,
              child: const Icon(
                Icons.smart_toy_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDarkMode ? 0.2 : 0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: isWelcome
                  ? const ChatWelcomeContent()
                  : Directionality(
                      textDirection: _getDirection(content),
                      child: MarkdownBody(
                        data: _formatMarkdown(content),
                        styleSheet: MarkdownStyleSheet(
                          p: GoogleFonts.cairo(
                            color: textColor,
                            fontSize: 15,
                            height: 1.7,
                            fontWeight: FontWeight.w500,
                          ),
                          strong: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: secondaryTextColor,
                          ),
                          listBullet: TextStyle(color: textColor),
                          listIndent: 24,
                          listBulletPadding: const EdgeInsets.only(top: 4),
                        ),
                      ),
                    ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 18,
              backgroundImage: (currentUser?.photoURL != null)
                  ? NetworkImage(currentUser!.photoURL!)
                  : const AssetImage(Assets.imagesLogoApp) as ImageProvider,
            ),
          ],
        ],
      ),
    );
  }
}
