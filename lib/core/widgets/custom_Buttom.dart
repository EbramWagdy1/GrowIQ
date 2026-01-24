// ignore: file_names
import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';

class CustomButtom extends StatelessWidget {
  const CustomButtom({super.key , this.text});
  final String? text ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 284,
      height: 52,
      child: ElevatedButton(onPressed: (){},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
       child: Text(text ?? "Next",
       style: TextStyle(
        color:AppColors.textColorPrimary,
        fontSize: 24,
       ),),
      ),
    );
  }
}