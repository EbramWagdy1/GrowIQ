import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/chat/view/widgets/chat_bubble.dart';
import 'package:growiq/features/chat/view/widgets/chat_input_area.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';
import 'package:growiq/features/chat/view_model/chat_state.dart';
import 'package:growiq/core/utils/app_colors.dart';

import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final scrollController = ScrollController();

  void _scrollToBottom() {
    if (!scrollController.hasClients) return;

    Future.delayed(const Duration(milliseconds: 50), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppLocalizations.of(context)!.chat),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            _scrollToBottom();

            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    controller: scrollController,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
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

                if (state.isSending)
                  const LinearProgressIndicator(
                    backgroundColor: AppColors.lightMint,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondaryColor,
                    ),
                  ),

                ChatInputArea(controller: controller),
                SizedBox(height: 20),
              ],
            );
          },
        ),
      ),
    );
  }
}
