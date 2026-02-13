import 'package:flutter/material.dart';

Widget socialButton({
  required Widget icon,
  required String text,
  required VoidCallback onTap,
}) {
  return ElevatedButton.icon(
    onPressed: onTap,
    icon: icon,
    label: Text(text),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      side: BorderSide(color: Colors.grey.shade300),
      padding: EdgeInsets.symmetric(vertical: 14),
    ),
  );
}
