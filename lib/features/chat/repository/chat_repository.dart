import '../../../core/services/groq_service.dart';
import '../model/chat_message.dart';

class ChatRepository {
  final GroqService _service;
  static const String _apiKey = "YOUR_GROQ_API_KEY_HERE"; // Ideally from a secure env config

  ChatRepository(this._service);

  /// Get AI reply with context and localized persona
  Future<String> getChatReply({
    required List<ChatMessage> chatHistory,
    String? systemInstruction,
  }) async {
    // 🧠 Prompt Engineering: Inject specialized agricultural persona
    final List<Map<String, String>> messagesForApi = [
      {
        "role": "system",
        "content": systemInstruction ?? _defaultSystemPrompt,
      },
      ...chatHistory.map((m) => m.toJson()),
    ];

    try {
      return await _service.sendMessage(
        messages: messagesForApi,
        apiKey: _apiKey,
      );
    } catch (e) {
      rethrow;
    }
  }

  // 🌿 Specialized Agricultural Persona
  static const String _defaultSystemPrompt = """
You are GrowIQ, a high-tech AI smart farm assistant. 
Your goal is to help users manage their plants and farms efficiently. 
You are an expert in agriculture, plant diseases, irrigation, and smart farming technology.
- Be helpful, precise, and encouraging.
- If asked about plant health, provide specific actionable advice.
- Use emojis like 🌿, 🚜, 💧, 🪴 to make the conversation engaging.
- Support both Arabic and English naturally based on user input.
""";
}
