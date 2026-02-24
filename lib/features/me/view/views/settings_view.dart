import 'package:flutter/material.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/me/view/widgets/profile_menu_item.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [ 
                  ProfileMenuItem(
                    text: "Notifications",
                    icon: Icons.notifications_outlined,
                    trailing: Transform.scale(
                      scale: 1,
                      child: Switch(
                        value: false,
                        onChanged: (val) {},
                        activeColor: Colors.black,
                        inactiveThumbColor: Colors.black,
                        inactiveTrackColor: Colors.grey[300],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}