import 'package:growiq/core/errors/app_result.dart';
import 'package:growiq/core/errors/error_mapper.dart';
import 'package:growiq/core/errors/exceptions.dart';
import 'package:growiq/core/errors/failures.dart';
import '../../../core/services/groq_service.dart';
import '../model/chat_message.dart';

class ChatRepository {
  final GroqService _service;
  
  // NOTE: In a real project, this should be moved to a secure config or env variable
  static const String _apiKey = "gsk_vCq7eW8sL1mF9xN2p3R5dJ0Kz6Q4w2B8sV1gM7lP9xN2p3R5kJ"; 

  ChatRepository(this._service);

  /// Get AI reply with context and localized persona
  Future<AppResult<String>> getChatReply({
    required List<ChatMessage> chatHistory,
    String? systemInstruction,
  }) async {
    // 🧠 Prompt Engineering: Inject specialized agricultural persona
    final List<Map<String, String>> messagesForApi = [
      {
        "role": "system",
        "content": systemInstruction ?? _defaultSystemPrompt,
      },
      ...chatHistory.where((m) => m.content != "welcome_trigger").map((m) => m.toJson()),
    ];

    try {
      final reply = await _service.sendMessage(
        messages: messagesForApi,
        apiKey: _apiKey,
      );
      return Success(reply);
    } on AppException catch (e) {
      return FailureResult(ErrorMapper.mapToFailure(e));
    } catch (e) {
      return const FailureResult(ServerFailure("Unable to get AI response"));
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
