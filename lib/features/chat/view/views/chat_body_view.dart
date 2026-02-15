import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/chat/view/widgets/chat_bubble.dart';
import 'package:growiq/features/chat/view/widgets/chat_input_area.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';
import 'package:growiq/features/chat/view_model/chat_state.dart';


class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Chat'),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          _scrollToBottom();
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  itemCount: state.messages.length,
                  itemBuilder: (context, index) {
                    final msg = state.messages[index];
                    if (msg.role == "system") return const SizedBox();
                    return ChatBubble(
                      content: msg.content,
                      isUser: msg.role == "user",
                      index: index,
                    );
                  },
                ),
              ),
              if (state.isSending) const LinearProgressIndicator(),
              ChatInputArea(controller: controller),
            ],
          );
        },
      ),
    );
  }
}