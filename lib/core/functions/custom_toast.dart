import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart' show Toast, Fluttertoast, ToastGravity;
import 'package:growiq/core/utils/app_colors.dart';

void showToast(String message){
   Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.primaryColor,
        textColor: Colors.white,
        fontSize: 16.0
    );
}