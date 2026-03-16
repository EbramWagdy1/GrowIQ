import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:growiq/core/utils/app_colors.dart';

class AppTextStyles {
  static TextStyle headlineLarge(BuildContext context) => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    color: Theme.of(context).colorScheme.onSurface,
    height: 1.2,
  );

  static TextStyle titleMedium(BuildContext context) => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: Theme.of(context).colorScheme.onSurface,
  );

  static TextStyle bodyText1(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  );

  static TextStyle bodyText2(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).colorScheme.onSurfaceVariant,
  );

  static TextStyle hintText(BuildContext context) => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: Theme.of(context).brightness == Brightness.dark 
        ? AppColors.darkTextColorSecondary 
        : AppColors.textColorSecondary,
  );

  static TextStyle buttonText(BuildContext context) => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Colors.white,
  );
}
