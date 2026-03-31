class ChatMessage {
  final String role;
  final String content;

  const ChatMessage({required this.role, required this.content});

  ChatMessage copyWith({String? role, String? content}) =>
      ChatMessage(role: role ?? this.role, content: content ?? this.content);

  Map<String, String> toJson() => {
        "role": role,
        "content": content,
      };
}
