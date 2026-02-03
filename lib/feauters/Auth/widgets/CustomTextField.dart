
import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_text_style.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.text});
    final String text ;
  @override
  Widget build(BuildContext context) {

 
    return TextField(
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