import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

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

    final inactiveColor = Colors.white;

    final isRtl = Directionality.of(context) == TextDirection.rtl;

    final navItems = [
      GlazeNavBarItem(
        child: Icon(
          Icons.home,
          color: currentIndex == 0 ? colorScheme.secondary : inactiveColor,
        ),
        label: AppLocalizations.of(context)!.home,
        labelStyle: TextStyle(color: inactiveColor),
      ),
      GlazeNavBarItem(
        child: SvgPicture.asset(
          Assets.controlicon,
          width: 24,
          height: 24,
          color: currentIndex == 1 ? colorScheme.secondary : inactiveColor,
        ),
        label: AppLocalizations.of(context)!.control,
        labelStyle: TextStyle(color: inactiveColor),
      ),
      GlazeNavBarItem(
        child: Icon(
          Icons.notifications,
          color: currentIndex == 2 ? colorScheme.secondary : inactiveColor,
        ),
        label: AppLocalizations.of(context)!.notifications,
        labelStyle: TextStyle(color: inactiveColor),
      ),
      GlazeNavBarItem(
        child: Icon(
          Icons.person,
          color: currentIndex == 3 ? colorScheme.secondary : inactiveColor,
        ),
        label: AppLocalizations.of(context)!.profile,
        labelStyle: TextStyle(color: inactiveColor),
      ),
    ];

    return Directionality(
      textDirection: TextDirection.ltr,
      child: GlazeNavBar(
        index: isRtl ? ( navItems.length - 1 - currentIndex ) : currentIndex,
        items: isRtl ? navItems.reversed.toList() : navItems,
        gradient: isDark ? AppColors.darkNavBarGradient : AppColors.navBarGradient,
        buttonGradient: isDark ? AppColors.darkNavBarGradient : AppColors.navBarGradient,
        onTap: (index) {
          final targetIndex = isRtl ? (navItems.length - 1 - index) : index;
          if (targetIndex != currentIndex) {
            onTap(targetIndex);
          }
        },
      ),
    );

  }
}
