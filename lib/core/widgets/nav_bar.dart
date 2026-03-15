import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    return GlazeNavBar(
      index: currentIndex,
      items: [
        GlazeNavBarItem(
          child: Icon(
            Icons.home,
            color: currentIndex == 0 ? colorScheme.secondary : Colors.white70,
          ),
          label: 'Home',
          labelStyle: const TextStyle(color: Colors.white70),
        ),
        GlazeNavBarItem(
          child: SvgPicture.asset(
            Assets.controlicon,
            width: 24,
            height: 24,
            color: currentIndex == 1 ? colorScheme.secondary : Colors.white70,
          ),
          label: 'Control',
          labelStyle: const TextStyle(color: Colors.white70),
        ),
        GlazeNavBarItem(
          child: Icon(
            Icons.notifications,
            color: currentIndex == 2 ? colorScheme.secondary : Colors.white70,
          ),
          label: 'Notification',
          labelStyle: const TextStyle(color: Colors.white70),
        ),
        GlazeNavBarItem(
          child: Icon(
            Icons.person,
            color: currentIndex == 3 ? colorScheme.secondary : Colors.white70,
          ),
          label: 'ME',
          labelStyle: const TextStyle(color: Colors.white70),
        ),
      ],
      gradient: isDark ? AppColors.darkNavBarGradient : AppColors.navBarGradient,
      buttonGradient: isDark ? AppColors.darkNavBarGradient : AppColors.navBarGradient,
      onTap: onTap,
    );
  }
}
