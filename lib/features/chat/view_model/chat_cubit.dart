import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/chat/repository/chat_repository.dart';
import 'package:growiq/features/chat/model/chat_message.dart';
import 'chat_state.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;
  Timer? _typewriterTimer;

  ChatCubit(this._repository)
    : super(
        ChatState(
          messages: [
            ChatMessage(role: "assistant", content: "welcome_trigger"),
          ],
          isSending: false,
        ),
      );

  Future<void> sendMessage(String text, {BuildContext? context}) async {
    if (text.trim().isEmpty || isClosed) return;

    String? customInstruction;
    if (context != null) {
      final l10n = AppLocalizations.of(context)!;
      if (text == l10n.arabic) {
        customInstruction = l10n.arabicPrompt;
      } else if (text == l10n.english) {
        customInstruction = l10n.englishPrompt;
      }
    }

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(role: "user", content: text));

    if (!isClosed) {
      emit(state.copyWith(messages: updatedMessages, isSending: true));
    }

    try {
      final reply = await _repository.getChatReply(
        chatHistory: updatedMessages,
        systemInstruction: customInstruction,
      );

      if (!isClosed) {
        _typeWriter(reply);
      }
    } catch (e) {
      if (!isClosed) {
        emit(state.copyWith(isSending: false));
      }
    }
  }

  void stopGeneration() {
    if (_typewriterTimer != null && _typewriterTimer!.isActive) {
      _typewriterTimer!.cancel();
      _typewriterTimer = null;
      if (!isClosed) {
        emit(state.copyWith(isSending: false));
      }
      debugPrint("Generation stopped by user");
    }
  }

  void _typeWriter(String fullText) {
    if (isClosed) return;
    
    _typewriterTimer?.cancel();
    
    final messages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(role: "assistant", content: ""));

    // Ensure we don't emit if closed during async gap before this call
    if (isClosed) return;
    emit(state.copyWith(messages: messages, isSending: true));

    int index = 0;
    _typewriterTimer = Timer.periodic(const Duration(milliseconds: 25), (timer) {
      if (isClosed || index >= fullText.length) {
        timer.cancel();
        _typewriterTimer = null;
        if (!isClosed) {
          emit(state.copyWith(isSending: false));
        }
        return;
      }

      final last = messages.last.copyWith(
        content: messages.last.content + fullText[index],
      );

      messages[messages.length - 1] = last;

      if (!isClosed) {
        emit(state.copyWith(messages: List.from(messages)));
      }
      index++;
    });
  }

  @override
  Future<void> close() {
    _typewriterTimer?.cancel();
    return super.close();
  }
}
