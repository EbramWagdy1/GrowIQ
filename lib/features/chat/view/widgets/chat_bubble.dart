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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
              radius: 18,
              backgroundColor: AppColors.secondaryColor,
              child: Icon(
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
                color: isUser ? lightMint : lightMint.withAlpha(150),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25),
                  topRight: const Radius.circular(25),
                  bottomLeft: Radius.circular(isUser ? 25 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
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
                            color: primaryTeal,
                            fontSize: 15,
                            height: 1.7,
                            fontWeight: FontWeight
                                .w500, 
                          ),
                          strong: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor,
                          ),
                          listBullet: const TextStyle(color: primaryTeal),
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
