import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';
import 'package:image_picker/image_picker.dart'; 
import 'package:file_picker/file_picker.dart';  

class ChatInputArea extends StatelessWidget {
  final TextEditingController controller;

  const ChatInputArea({super.key, required this.controller});

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
    }
  }


  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color inputBgColor = Color(0xFFE9F5F2);
    const Color iconColor = Color(0xFF385123);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 8), 
        decoration: BoxDecoration(
          color: inputBgColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Type your message here...',
                  hintStyle: TextStyle(color: Colors.black54, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
            _buildSmallIconButton(Icons.camera_alt_outlined, iconColor, _pickImage),
            _buildSmallIconButton(Icons.attach_file, iconColor, _pickFile),
            _buildSmallIconButton(Icons.send_rounded, iconColor, () {
              if (controller.text.trim().isNotEmpty) {
                context.read<ChatCubit>().sendMessage(controller.text);
                controller.clear();
              }
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallIconButton(IconData icon, Color color, VoidCallback onPressed) {
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