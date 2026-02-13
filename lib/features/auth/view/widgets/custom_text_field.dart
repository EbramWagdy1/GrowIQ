import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.text,
    this.onChanged,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.onEyePressed,
    this.validator,
  });

  final String text;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final bool obscureText;
  final VoidCallback? onEyePressed;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      style: AppTextStyles.bodyText1.copyWith(fontSize: 16),
      decoration: InputDecoration(
        // Label that floats when focused
        labelText: text,
        labelStyle: AppTextStyles.bodyText1.copyWith(
          fontSize: 16,
          color: Colors.grey[600],
        ),
        hintText: '',
        hintStyle: AppTextStyles.hintText.copyWith(
          fontSize: 16,
          color: Colors.grey[400],
        ),
        filled: true,
        fillColor: Colors.white,
        suffixIcon: onEyePressed != null
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey[600],
                ),
                onPressed: onEyePressed,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.grey[400]!,
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }
}
