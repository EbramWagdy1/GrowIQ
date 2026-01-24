import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color textColorPrimary = Color(0xFF2E2E2E); 
  static const Color textColorSecondary = Color(0xFFC4C4C4);
  static const Color textColorWhite = Color(0xFFFFFFFF);     
  static const Color textColorAbout = Color(0xFF000000);    
}

class AppTextStyles {
  
  static TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w600, 
    color: AppColors.textColorPrimary,
    height: 1.2,
  );

  static TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textColorPrimary,
  );
  
  static TextStyle get bodyText1 => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColorPrimary,
  );

  static TextStyle get bodyText2 => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textColorAbout,
  );

  
  static TextStyle get hintText => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textColorSecondary,
  );


  static TextStyle get buttonText => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textColorWhite,
  );
}