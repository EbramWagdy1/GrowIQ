import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/features/home/view/widgets/weather_section.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeBar extends StatelessWidget {
  final VoidCallback? onAddDevice;
  const HomeBar({super.key, this.onAddDevice});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        final user = snapshot.data;
        final name = user?.displayName ?? AppStrings.guestUser;
        final photoUrl = user?.photoURL;

        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundGradient,
          ),
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundImage: photoUrl != null
                        ? CachedNetworkImageProvider(user!.photoURL!)
                        : AssetImage(Assets.imagesOnboarding1) as ImageProvider,
                    backgroundColor: AppColors.white12,
                  ),
                  title: Text(
                    AppStrings.welcome,
                    style: AppTextStyles.hintText.copyWith(
                      color: AppColors.white70,
                    ),
                  ),
                  subtitle: Text(
                    name,
                    style: AppTextStyles.buttonText.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.add, color: AppColors.white),
                        onPressed: onAddDevice,
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          Assets.svgsQr,
                          color: AppColors.white,
                        ),
                        onPressed: () {
                          customNavigate(context, '/scanner');
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                const WeatherSection(),
              ],
            ),
          ),
        );
      },
    );
  }
}
