import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';
import 'package:growiq/features/chat/view_model/chat_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ChatInputArea extends StatelessWidget {
  final TextEditingController controller;

  const ChatInputArea({super.key, required this.controller});

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {}
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {}
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color inputBgColor = isDarkMode ? Colors.grey[850]! : AppColors.lightMint;
    final Color iconColor = isDarkMode ? Colors.white70 : AppColors.iconColor;
    final Color textColor = isDarkMode ? Colors.white : Colors.black87;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 8),
        decoration: BoxDecoration(
          color: inputBgColor,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            if (isDarkMode)
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: BlocBuilder<ChatCubit, ChatState>(
          builder: (context, state) {
            return Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    style: TextStyle(color: textColor, fontSize: 15),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.typeMessage,
                      hintStyle: TextStyle(
                        color: isDarkMode ? Colors.white54 : Colors.black54,
                        fontSize: 14,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                _buildSmallIconButton(
                  Icons.camera_alt_outlined,
                  iconColor,
                  _pickImage,
                ),
                _buildSmallIconButton(Icons.attach_file, iconColor, _pickFile),
                _buildSmallIconButton(
                  state.isSending ? Icons.stop_circle_rounded : Icons.send_rounded,
                  state.isSending ? Colors.redAccent : AppColors.primaryColor,
                  () {
                    if (state.isSending) {
                      context.read<ChatCubit>().stopGeneration();
                    } else if (controller.text.trim().isNotEmpty) {
                      context.read<ChatCubit>().sendMessage(controller.text, context: context);
                      controller.clear();
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSmallIconButton(
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: 38,
      child: IconButton(
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        icon: Icon(icon, color: color, size: 22),
        onPressed: onPressed,
      ),
    );
  }
}
