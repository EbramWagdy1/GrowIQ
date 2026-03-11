import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/features/me/view/widgets/profile_menu_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/features/auth/view_model/auth_state.dart';
import 'package:growiq/core/services/service_locator.dart';

class MeView extends StatelessWidget {
  const MeView({super.key});

  @override
  Widget build(BuildContext context) {
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

                StreamBuilder(
                  stream: getIt<AuthCubit>().authStateChanges,
                  builder: (context, snapshot) {
                    final user = snapshot.data;
                    final name = user?.displayName ?? "Guest User";
                    final email = user?.email ?? "No Email";
                    final photoUrl = user?.photoURL;

                    return Column(
                      children: [
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
                                ? CachedNetworkImageProvider(user!.photoURL!)
                                : const AssetImage(Assets.imagesLogoApp)
                                      as ImageProvider,
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
                      ],
                    );
                  },
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
                BlocProvider.value(
                  value: getIt<AuthCubit>(),
                  child: Builder(
                    builder: (context) {
                      return BlocListener<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if (state is SignOutSuccessState) {
                            customReplacementNavigate(context, "/Login");
                          } else if (state is SignOutFailureState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error: ${state.errMessage}')),
                            );
                          }
                        },
                        child: ProfileMenuItem(
                          text: "Logout",
                          icon: Icons.logout,
                          onTap: () {
                            context.read<AuthCubit>().signOut();
                          },
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
