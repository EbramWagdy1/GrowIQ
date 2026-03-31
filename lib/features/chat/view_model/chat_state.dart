import 'package:growiq/features/chat/model/chat_message.dart';

class ChatState {
  final List<ChatMessage> messages;
  final bool isSending;
  final String? errorMessage; // 🔹 Added error message support

  const ChatState({
    required this.messages,
    required this.isSending,
    this.errorMessage,
  });

  factory ChatState.initial() => const ChatState(
        messages: [
          ChatMessage(role: "assistant", content: "welcome_trigger"),
        ],
        isSending: false,
      );

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isSending,
    String? errorMessage,
    bool clearError = false, // 🔹 Helper to clear error
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
