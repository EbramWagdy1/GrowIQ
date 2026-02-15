import 'package:flutter/material.dart';
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

  static const Color primaryTeal = Color(0xFF004D40);
  static const Color lightMint = Color(0xFFE8F5E9);

  @override
  Widget build(BuildContext context) {
    bool isWelcome = !isUser && index == 0;
    bool isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(content);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFF00A67E),
              child: Icon(Icons.smart_toy_outlined, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isUser ? lightMint : lightMint.withAlpha(150),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(25),
                  topRight: const Radius.circular(25),
                  bottomLeft: Radius.circular(isUser ? 25 : 0),
                  bottomRight: Radius.circular(isUser ? 0 : 25),
                ),
              ),
              child: isWelcome
                  ? const ChatWelcomeContent()
                  : Text(
                      content,
                      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                      style: const TextStyle(color: primaryTeal, fontSize: 15, height: 1.5),
                    ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 18, 
              backgroundImage: AssetImage('assets/user_avatar.png')
            ),
          ],
        ],
      ),
    );
  }
}