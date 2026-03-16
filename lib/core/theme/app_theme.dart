import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    primaryColor: AppColors.primaryColor,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      surface: AppColors.surfaceColor,
      onSurface: AppColors.textColorPrimary,
      onSurfaceVariant: AppColors.textColorSecondary,
      error: AppColors.errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.textColorPrimary),
      titleTextStyle: const TextStyle(
        color: AppColors.textColorPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textColorPrimary),
      bodyMedium: TextStyle(color: AppColors.textColorPrimary),
      titleLarge: TextStyle(color: AppColors.textColorPrimary, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surfaceColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.surfaceColor,
      surfaceTintColor: AppColors.surfaceColor,
      titleTextStyle: const TextStyle(
        color: AppColors.textColorPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: const TextStyle(
        color: AppColors.textColorSecondary,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    primaryColor: AppColors.darkPrimaryColor,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimaryColor,
      secondary: AppColors.darkSecondaryColor,
      surface: AppColors.darkSurfaceColor,
      onSurface: AppColors.darkTextColorPrimary,
      onSurfaceVariant: AppColors.darkTextColorSecondary,
      surfaceContainerHighest: AppColors.darkCardColor, // Used in ProfileView
      error: AppColors.errorColor,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBackgroundColor,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.darkPrimaryColor),
      titleTextStyle: const TextStyle(
        color: AppColors.darkTextColorPrimary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
      ),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkTextColorPrimary, fontSize: 16),
      bodyMedium: TextStyle(color: AppColors.darkTextColorSecondary, fontSize: 14),
      titleLarge: TextStyle(
        color: AppColors.darkTextColorPrimary, 
        fontWeight: FontWeight.bold,
        fontSize: 22,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.darkCardColor,
      elevation: 0, // Flat premium look
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.darkSurfaceColor, width: 1),
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: AppColors.darkSurfaceColor,
      surfaceTintColor: AppColors.darkSurfaceColor,
      titleTextStyle: const TextStyle(
        color: AppColors.darkTextColorPrimary,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      contentTextStyle: const TextStyle(
        color: AppColors.darkTextColorSecondary,
        fontSize: 16,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
  );
}
