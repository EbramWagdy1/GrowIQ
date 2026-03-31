import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/errors/app_result.dart';
import 'package:growiq/features/chat/repository/chat_repository.dart';
import 'package:growiq/features/chat/model/chat_message.dart';
import 'chat_state.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository _repository;
  Timer? _typewriterTimer;
  String? _currentSystemInstruction;

  ChatCubit(this._repository)
      : super(
          const ChatState(
            messages: [
              ChatMessage(role: "assistant", content: "welcome_trigger"),
            ],
            isSending: false,
          ),
        );

  Future<void> sendMessage(String text, {BuildContext? context}) async {
    if (text.trim().isEmpty || isClosed) return;

    // 🛡️ Prepare state
    emit(state.copyWith(isSending: true, clearError: true));

    // 🧠 Language Selector Logic (Internal mapping to avoid context issues)
    if (context != null) {
      final l10n = AppLocalizations.of(context)!;
      if (text == l10n.arabic || text == "العربية") {
        _currentSystemInstruction = l10n.arabicPrompt;
      } else if (text == l10n.english || text == "English") {
        _currentSystemInstruction = l10n.englishPrompt;
      }
    }

    final updatedMessages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(role: "user", content: text));

    if (!isClosed) {
      emit(state.copyWith(messages: updatedMessages, isSending: true));
    }

    try {
      // 🚀 Call repository with a timeout safety check if possible
      final result = await _repository.getChatReply(
        chatHistory: updatedMessages,
        systemInstruction: _currentSystemInstruction,
      ).timeout(const Duration(seconds: 30), onTimeout: () {
        throw TimeoutException("Check your internet connection");
      });

      switch (result) {
        case Success(data: var reply):
          if (!isClosed) {
            _typeWriter(reply);
          }
        case FailureResult(failure: var failure):
          if (!isClosed) {
            emit(state.copyWith(
              isSending: false,
              errorMessage: failure.message,
            ));
          }
      }
    } catch (e) {
      if (!isClosed) {
        String msg = "Unable to reach AI assistant";
        if (e is TimeoutException) msg = "Request timed out. Try again.";
        
        emit(state.copyWith(
          isSending: false,
          errorMessage: msg,
        ));
      }
    }
  }

  void stopGeneration() {
    _typewriterTimer?.cancel();
    _typewriterTimer = null;
    if (!isClosed) {
      emit(state.copyWith(isSending: false));
    }
  }

  void _typeWriter(String fullText) {
    if (isClosed) return;
    _typewriterTimer?.cancel();

    final messages = List<ChatMessage>.from(state.messages)
      ..add(ChatMessage(role: "assistant", content: ""));

    if (isClosed) return;
    emit(state.copyWith(messages: messages, isSending: true));

    int index = 0;
    _typewriterTimer =
        Timer.periodic(const Duration(milliseconds: 15), (timer) {
      if (isClosed || index >= fullText.length) {
        timer.cancel();
        _typewriterTimer = null;
        if (!isClosed) {
          emit(state.copyWith(isSending: false));
        }
        return;
      }

      final currentMessages = List<ChatMessage>.from(state.messages);
      if (currentMessages.isEmpty) return;

      final last = currentMessages.last.copyWith(
        content: currentMessages.last.content + fullText[index],
      );

      currentMessages[currentMessages.length - 1] = last;

      if (!isClosed) {
        emit(state.copyWith(messages: currentMessages));
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
