import 'package:flutter/material.dart';
import 'package:glaze_nav_bar/glaze_nav_bar.dart';

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
        ),
        GlazeNavBarItem(
          child: Icon(
            Icons.wifi,
            color: currentIndex == 1 ? Colors.greenAccent : Colors.white,
          ),
          label: 'Control',
        ),
        GlazeNavBarItem(
          child: Icon(
            Icons.notifications,
            color: currentIndex == 2 ? Colors.greenAccent : Colors.white,
          ),
          label: 'Notification',
        ),
        GlazeNavBarItem(
          child: Icon(
            Icons.person,
            color: currentIndex == 3 ? Colors.greenAccent : Colors.white,
          ),
          label: 'ME',
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
