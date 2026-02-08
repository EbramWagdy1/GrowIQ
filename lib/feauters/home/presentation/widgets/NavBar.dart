import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';
import 'package:growiq/core/utils/app_assets.dart';

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
    return GlazeNavBar(
      index: currentIndex,
      items: [
        GlazeNavBarItem(
          child: Icon(
            Icons.home,
            color: currentIndex == 0 ? Colors.greenAccent : Colors.white,
          ),
          label: 'Home',
          labelStyle: TextStyle(color: Colors.white),
        ),
        GlazeNavBarItem(
          child: SvgPicture.asset(
            Assets.controlicon,
              width: 24,
        height: 24,
            color: currentIndex == 1
                ? Colors.greenAccent
                : Colors.white, 
          ),
          label: 'Control',
          labelStyle: TextStyle(color: Colors.white),
        ),
        GlazeNavBarItem(
          child: Icon(
            Icons.notifications,
            color: currentIndex == 2 ? Colors.greenAccent : Colors.white,
          ),
          label: 'Notification',
          labelStyle: TextStyle(color: Colors.white),
        ),
        GlazeNavBarItem(
          child: Icon(
            Icons.person,
            color: currentIndex == 3 ? Colors.greenAccent : Colors.white,
          ),
          label: 'ME',
          labelStyle: TextStyle(color: Colors.white),
        ),
      ],
      gradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Color(0xFF438E6E), Color(0xFF13281F)],
      ),
      buttonGradient: const LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [Color(0xFF438E6E), Color(0xFF13281F)],
      ),
      onTap: onTap,
    );
  }
}
