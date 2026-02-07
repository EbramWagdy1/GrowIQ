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
      decoration: InputDecoration(
        hintText: text,
        hintStyle: AppTextStyles.hintText.copyWith(fontSize: 20),

        suffixIcon: onEyePressed != null
            ? IconButton(
                icon: Icon(
                  obscureText
                      ? Icons.visibility_off
                      : Icons.visibility,
                  color: AppColors.textColorSecondary,
                ),
                onPressed: onEyePressed,
              )
            : null,

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textColorSecondary,
            width: 1.0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.textColorSecondary,
            width: 2.0,
          ),
        ),
      ),
    );
  }
}
