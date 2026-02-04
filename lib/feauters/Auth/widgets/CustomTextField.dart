
import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.text, this.onChanged, this.onFieldSubmitted});
    final String text ;
    final Function(String)? onChanged;
    final Function(String)? onFieldSubmitted;

    
  @override
  Widget build(BuildContext context) {

 
    return TextFormField(
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,

              decoration: InputDecoration(
                hintText: text,
                hintStyle: AppTextStyles.hintText.copyWith(fontSize: 20), // Light grey text
              
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textColorSecondary, width: 1.0),
                ),
                
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.textColorSecondary, width: 2.0),
                ),
              ),
            );
  }
}