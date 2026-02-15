import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/services/groq_service.dart';
import 'package:growiq/features/chat/model/chat_message.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GroqService service;
  final String apiKey = "YOUR_GROQ_API_KEY_HERE";

  // تعديل الـ Constructor ليبدأ برسالة ترحيبية
  ChatCubit(this.service) : super(ChatState(
    messages: [
      ChatMessage(
        role: "assistant", 
        content: "welcome_trigger", // المحتوى هنا لن يظهر لأن الـ UI سيعرض الـ WelcomeContent مكانه
      ),
    ],
    isSending: false,
  ));

// chat_cubit.dart
// chat_cubit.dart
Future<void> sendMessage(String text) async {
  if (text.trim().isEmpty) return;

  String apiInstruction = text;
  
  if (text == "Arabic") {
    apiInstruction = "تحدث بالعربية فقط. أنت مساعد GrowIQ الزراعي. اكتب النص التالي بدقة:\n"
        "أنا هنا لمساعدتك في إدارة محاصيلك وتربتك ونظام الري بدقة وعناية. كيف يمكنني مساعدتك اليوم؟\n\n"
        "هل تبحث عن نصائح بخصوص:\n"
        "١. جدولة الري\n"
        "٢. صحة التربة وإدارة العناصر الغذائية\n"
        "٣. اختيار المحاصيل وتخطيطها\n"
        "٤. مكافحة الآفات والأمراض\n"
        "٥. أي شيء آخر؟";
  } else if (text == "English") {
    apiInstruction = "Speak English only. Act as GrowIQ assistant. Write exactly:\n"
        "I'm here to help you manage your crops, soil, and irrigation with precision and care. How can I assist you today?\n\n"
        "Are you looking for advice on:\n"
        "1. Irrigation scheduling\n"
        "2. Soil health and nutrient management\n"
        "3. Crop selection and planning\n"
        "4. Pest and disease control\n"
        "5. Something else?";
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

    _typeWriter(reply); // سيكتب النص المترجم حرفاً بحرف
  } catch (e) {
    emit(state.copyWith(isSending: false));
  }
}

  void _typeWriter(String fullText) {
    final messages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(role: "assistant", content: ""));

    emit(state.copyWith(messages: messages, isSending: false));

    int index = 0;

    Timer.periodic(const Duration(milliseconds: 15), (timer) {
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

