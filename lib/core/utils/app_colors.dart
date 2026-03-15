import 'package:flutter/material.dart';

abstract class AppColors {
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color(0xFF004D40), Color(0xFF065547), Color(0xFF9EA7A6)],
    stops: [0.0, 0.4, 1],
  );

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: [Color(0xFF0F1413), Color(0xFF161B1A), Color(0xFF1E2624)],
    stops: [0.0, 0.4, 1],
  );

  static const LinearGradient navBarGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [Color(0xFF004D40), Color(0xFF065547), Color(0xFF7C8181)],
  );

  static const LinearGradient darkNavBarGradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [Color(0xFF0F1413), Color(0xFF1B2321), Color(0xFF242E2C)],
  );

  // 🔹 Light Mode Palette
  static const Color primaryColor = Color(0xFF004D40);
  static const Color secondaryColor = Color(0xFF009970);
  static const Color backgroundColor = Color(0xFFF4faf4);
  static const Color surfaceColor = Color(0xFFFFFFFF);

  // 🔹 Dark Mode Palette (Refined Premium)
  static const Color darkPrimaryColor = Color(0xFF00897B); // Muted Teal/Green
  static const Color darkSecondaryColor = Color(0xFF4DB6AC); // Soft Mint accent
  static const Color darkBackgroundColor = Color(0xFF0F1413); // Deep Organic Charcoal
  static const Color darkSurfaceColor = Color(0xFF1B2321); // Elevated Graphite
  static const Color darkCardColor = Color(0xFF242E2C); // Subtle Card contrast

  // 🔹 Text Colors - Light
  static const Color textColorPrimary = Color(0xFF2E2E2E);
  static const Color textColorSecondary = Color(0xFF757575);
  static const Color textColorWhite = Color(0xFFFFFFFF);
  static const Color textColorAbout = Color(0xFF000000);

  // 🔹 Text Colors - Dark
  static const Color darkTextColorPrimary = Color(0xFFE0E5E4); // Off-white for less eye strain
  static const Color darkTextColorSecondary = Color(0xFF94A3A1); // Muted teal-grey

  // Status Colors
  static const Color onlineColor = Color(0xFF00A86B);

  // Chat Colors
  static const Color lightMint = Color(0xFFE8F5E9);
  static const Color iconColor = Color(0xFF385123);

  // UI Colors
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;
  static const Color greyColor = Colors.grey;
  static const Color lightGreyColor = Color(0xFFF5F5F5);
  static const Color darkGreyColor = Color(0xFF303030);
  static const Color black87 = Colors.black87;
  static const Color black54 = Colors.black54;
  static const Color greenAccent = Colors.greenAccent;
  static const Color black = Colors.black;
  static const Color black54Opaque = Colors.black54;
  static const Color blue = Colors.blue;
  static const Color lightGreyBackground = Color(0xFFF5F5F5);
  static const Color greyShade300 = Color(0xFFE0E0E0);
  static const Color greyShade600 = Color(0xFF757575);
  static const Color darkGreyIcon = Color(0xFF4A4A4A);
  static const Color textColor2D = Color(0xFF2D2D2D);

  // Gradients
  static const Color healthyGradientStart = Color(0xFF66BB6A);
  static const Color healthyGradientEnd = Color(0xFF009688);
  static const Color unhealthyGradientStart = Color(0xFFFFA726);
  static const Color unhealthyGradientEnd = Color(0xFFEF5350);
  static const Color aiModeGradientStart = Color(0xFF7E57C2);
  static const Color aiModeGradientEnd = Color(0xFF8E24AA);

  // Teal Shades
  static const Color tealShade50 = Color(0xFFE0F2F1);
  static const Color tealShade400 = Color(0xFF26A69A);
  static const Color tealShade600 = Color(0xFF00897B);
  static const Color tealShade700 = Color(0xFF00796B);
  static const Color tealShade800 = Color(0xFF00695C);

  // Purple Shades
  static const Color purpleShade50 = Color(0xFFF3E5F5);
  static const Color purpleShade500 = Color(0xFF9C27B0);
  static const Color purpleShade600 = Color(0xFF8E24AA);
  static const Color purpleShade700 = Color(0xFF7B1FA2);

  // Orange Shades
  static const Color orangeShade50 = Color(0xFFFFF3E0);
  static const Color orangeShade600 = Color(0xFFFB8C00);
  static const Color orangeShade700 = Color(0xFFF57C00);

  // Grey Shades
  static const Color greyShade50 = Color(0xFFFAFAFA);
  static const Color greyShade200 = Color(0xFFEEEEEE);
  static const Color greyShade700 = Color(0xFF616161);

  // Social
  static const Color facebookBlue = Color(0xFF1877F2);
  static const Color googleRed = Color(0xFFDB4437);

  // Whites
  static const Color white = Colors.white;
  static const Color white70 = Colors.white70;
  static const Color white54 = Colors.white54;
  static const Color white24 = Colors.white24;
  static const Color white12 = Colors.white12;
  static const Color transparentWhite10 = Color(0x1AFFFFFF);
  static const Color transparentWhite05 = Color(0x0DFFFFFF);
}
