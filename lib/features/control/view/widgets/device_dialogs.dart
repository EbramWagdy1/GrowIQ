import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/home/view_model/device_cubit.dart';
import 'package:growiq/features/home/model/device_model.dart';

class DeviceDialogs {
  static void showRenameDialog({
    required BuildContext context,
    required DeviceModel device,
  }) {
    final controller = TextEditingController(text: device.name);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Rename Device"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter new name",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<DeviceCubit>().renameDevice(
                  device.id,
                  controller.text.trim(),
                );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  static void showDeleteDialog({
    required BuildContext context,
    required DeviceModel device,
    VoidCallback?
    onDeleted, // called after dialog closes (e.g. to pop detail view)
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete Device"),
        content: Text("Are you sure you want to remove '${device.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<DeviceCubit>().removeDevice(device.id);
              Navigator.pop(dialogContext); // close dialog only
              onDeleted?.call(); // caller handles page navigation
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
