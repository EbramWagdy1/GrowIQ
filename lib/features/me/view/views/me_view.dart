import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/features/me/view/widgets/profile_menu_item.dart'; 

class MeView extends StatelessWidget {
  const MeView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(), 
      builder: (context, snapshot) {
        final user = snapshot.data;
        final name = user?.displayName ?? "Guest User";
        final email = user?.email ?? "No Email";
        final photoUrl = user?.photoURL;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // --- 1. Profile Image ---
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: photoUrl != null
                            ? NetworkImage(photoUrl)
                            : const AssetImage(Assets.imagesLogoApp) as ImageProvider, 
                      ),
                    ),
                    const SizedBox(height: 20),

                    // --- 2. Name and Email ---
                    Text(
                      name, 
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF2D2D2D),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),

                    const SizedBox(height: 40),

                    // --- 3. Menu Items ---
                    // Profile
                    ProfileMenuItem(
                      text: "Profile",
                      icon: Icons.person_outline,
                      onTap: () {
                        customNavigate(context, '/profile-data');
                      },
                    ),
                    // Notifications
                    ProfileMenuItem(
                      text: "Notifications",
                      icon: Icons.notifications_outlined,
                      trailing: Transform.scale(
                        scale: 1,
                        child: Switch(
                          value: false,
                          onChanged: (val) {},
                          // ignore: deprecated_member_use
                          activeColor: Colors.black,
                          inactiveThumbColor: Colors.black,
                          inactiveTrackColor: Colors.grey[300],
                        ),
                      ),
                    ),
                    // Settings
                    ProfileMenuItem(
                      text: "Settings",
                      icon: Icons.settings_outlined,
                      onTap: () {
                        customNavigate(context, '/settings');
                      },
                    ),
                    // About
                    ProfileMenuItem(
                      text: "About",
                      icon: Icons.info_outline,
                      onTap: () {
                        customNavigate(context, '/about');
                      },
                    ),
                    // Logout
                    ProfileMenuItem(
                      text: "Logout",
                      icon: Icons.logout,
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          customReplacementNavigate(context, "/Login");
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}