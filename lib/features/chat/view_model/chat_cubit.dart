import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/services/groq_service.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/features/chat/model/chat_message.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GroqService service;
  final String apiKey = "YOUR_GROQ_API_KEY_HERE";

  ChatCubit(this.service)
    : super(
        ChatState(
          messages: [
            ChatMessage(role: "assistant", content: "welcome_trigger"),
          ],
          isSending: false,
        ),
      );

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    String apiInstruction = text;

    if (text == AppStrings.arabic) {
      apiInstruction = AppStrings.arabicPrompt;
    } else if (text == AppStrings.english) {
      apiInstruction = AppStrings.englishPrompt;
    }

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(role: "user", content: text));

    emit(state.copyWith(messages: updatedMessages, isSending: true));

    try {
      final messagesForApi = updatedMessages.map((e) => e.toJson()).toList();
      messagesForApi.last['content'] = apiInstruction;

      final reply = await service.sendMessage(
        messages: messagesForApi,
        apiKey: apiKey,
      );

      _typeWriter(reply);
    } catch (e) {
      emit(state.copyWith(isSending: false));
    }
  }

  void _typeWriter(String fullText) {
    final messages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(role: "assistant", content: ""));

    emit(state.copyWith(messages: messages, isSending: false));

    int index = 0;

    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (index >= fullText.length) {
        timer.cancel();
        return;
      }

      final last = messages.last.copyWith(
        content: messages.last.content + fullText[index],
      );

      messages[messages.length - 1] = last;

      emit(state.copyWith(messages: List.from(messages)));
      index++;
    });
  }
}
