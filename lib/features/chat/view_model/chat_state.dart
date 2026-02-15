
import 'package:growiq/features/chat/model/chat_message.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isSending;

  const ChatState({
    required this.messages,
    required this.isSending,
  });

  factory ChatState.initial() => ChatState(
        messages: [
          ChatMessage(
              role: "system",
              content:
                  "You are GrowIQ AI, a smart farming assistant. Help users with irrigation, soil health, and crop management.")
        ],
        isSending: false,
      );

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }
}
