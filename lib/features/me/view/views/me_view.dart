import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/features/me/view/widgets/profile_menu_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/features/auth/view_model/auth_state.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/services/auth_service.dart';

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthCubit>(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: BlocListener<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is SignOutSuccessState) {
                    customReplacementNavigate(context, "/Login");
                  } else if (state is SignOutFailureState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            '${AppStrings.errorPrefix}${state.errMessage}'),
                      ),
                    );
                  }
                },
                child: Column(
                  children: [
                    const SizedBox(height: 40),

                    // --- User Info section ---
                    Builder(builder: (context) {
                      final user = getIt<AuthService>().currentUser;
                      final name = user?.displayName ?? AppStrings.guestUser;
                      final email = user?.email ?? AppStrings.noEmail;
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
                                  color: AppColors.black.withValues(alpha: 0.2),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: photoUrl != null
                                  ? CachedNetworkImageProvider(photoUrl)
                                  : const AssetImage(Assets.imagesLogoApp)
                                      as ImageProvider,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // --- 2. Name and Email ---
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            email,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 40),

                    // --- 3. Menu Items ---
                    // Profile
                    Builder(builder: (context) {
                      return ProfileMenuItem(
                        text: AppStrings.profile,
                        icon: Icons.person_outline,
                        onTap: () async {
                          final result =
                              await customNavigate(context, '/profile-data');
                          if (result == true) {
                            setState(() {}); // Trigger rebuild to show new profile info
                          }
                        },
                      );
                    }),
                    // Notifications

                    // Settings
                    ProfileMenuItem(
                      text: AppStrings.settings,
                      icon: Icons.settings_outlined,
                      onTap: () {
                        customNavigate(context, '/settings');
                      },
                    ),
                    // Plants Info
                    ProfileMenuItem(
                      text: 'Plants Information',
                      icon: Icons.local_florist_outlined,
                      onTap: () {
                        customNavigate(context, '/plants-info');
                      },
                    ),
                    // About
                    ProfileMenuItem(
                      text: AppStrings.aboutApp,
                      icon: Icons.info_outline,
                      onTap: () {
                        customNavigate(context, '/about');
                      },
                    ),
                    // Logout
                    Builder(builder: (context) {
                      return ProfileMenuItem(
                        text: AppStrings.logout,
                        icon: Icons.logout,
                        onTap: () {
                          context.read<AuthCubit>().signOut();
                        },
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
