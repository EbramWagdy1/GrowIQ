import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/features/me/view/widgets/profile_menu_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/features/auth/view_model/auth_state.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class MeView extends StatefulWidget {
  const MeView({super.key});

  @override
  State<MeView> createState() => _MeViewState();
}

class _MeViewState extends State<MeView> {
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
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is SignOutSuccessState) {
                  customReplacementNavigate(context, "/Login");
                } else if (state is SignOutFailureState) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${AppLocalizations.of(context)!.errorPrefix}${state.errMessage}'),
                    ),
                  );
                }
              },
              builder: (context, state) {
                final user = context.read<AuthCubit>().currentUser;
                final name = user?.displayName ?? AppLocalizations.of(context)!.guestUser;
                final email = user?.email ?? AppLocalizations.of(context)!.noEmail;
                final photoUrl = user?.photoURL;

                return Column(
                  children: [
                    const SizedBox(height: 40),

                    // --- User Info section ---
                    Column(
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
                    ),

                    const SizedBox(height: 30),

                    // --- 3. Menu Items ---
                    // Profile
                    ProfileMenuItem(
                      text: AppLocalizations.of(context)!.profile,
                      icon: Icons.person_outline,
                      onTap: () async {
                        await customNavigate(context, '/profile-data');
                      },
                    ),
                    // Integrations
                    ProfileMenuItem(
                      text: AppLocalizations.of(context)!.integrations,
                      icon: Icons.extension_outlined,
                      onTap: () {
                        customNavigate(context, '/integrations');
                      },
                    ),
                    // Settings
                    ProfileMenuItem(
                      text: AppLocalizations.of(context)!.settings,
                      icon: Icons.settings_outlined,
                      onTap: () {
                        customNavigate(context, '/settings');
                      },
                    ),
                    // Plants Info
                    ProfileMenuItem(
                      text: AppLocalizations.of(context)!.plantsInformation,
                      icon: Icons.local_florist_outlined,
                      onTap: () {
                        customNavigate(context, '/plants-info');
                      },
                    ),
                    // About
                    ProfileMenuItem(
                      text: AppLocalizations.of(context)!.aboutApp,
                      icon: Icons.info_outline,
                      onTap: () {
                        customNavigate(context, '/about');
                      },
                    ),

                    // Contact Us
                    ProfileMenuItem(
                      text: AppLocalizations.of(context)!.contactUs,
                      icon: Icons.contact_support,
                      onTap: () {
                        customNavigate(context, '/contact-us');
                      },
                    ),
                    // Logout
                    ProfileMenuItem(
                      text: AppLocalizations.of(context)!.logout,
                      icon: Icons.logout,
                      onTap: () {
                        context.read<AuthCubit>().signOut();
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
