import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/core/widgets/NavBar.dart';

class CustomNavBarShell extends StatelessWidget {
  final Widget child;
  const CustomNavBarShell({super.key, required this.child});

  int _getIndex(String location) {
    if (location.startsWith('/control')) return 1;
    if (location.startsWith('/notification')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0; 
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final currentIndex = _getIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: CustomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              context.go('/Home');
              break;
            case 1:
              context.go('/control');
              break;
            case 2:
              context.go('/notification');
              break;
            case 3:
              context.go('/profile');
              break;
          }
        },
      ),
    );
  }
}
