import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamMemberCard extends StatelessWidget {
  final String name;
  final String role;
  final String imagePath;
  final String? linkedInLink;
  final String? githubLink;

  const TeamMemberCard({
    super.key,
    required this.name,
    required this.role,
    required this.imagePath,
    this.linkedInLink,
    this.githubLink,
  });

/// Function to launch URL
Future<void> _launchURL(String url) async {
  final uri = Uri.parse(url);

  try {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, 
    );

    if (!launched) {
      debugPrint("Could not launch $url");
    }
  } catch (e) {
    debugPrint("Error launching URL: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.only(
        top: 40,
        bottom: 30,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black54 
                : AppColors.black.withValues(alpha: 0.1),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Profile Image
          CircleAvatar(
            radius: 75,
            backgroundColor: AppColors.greyShade300,
            backgroundImage: AssetImage(imagePath),
          ),

          const SizedBox(height: 28),

          /// Name
          Text(
            name,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 14),

          /// Role
          Text(
            role,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 30),

          /// Social Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// LinkedIn
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: linkedInLink != null ? () => _launchURL(linkedInLink!) : null,
                child: FaIcon(
                  FontAwesomeIcons.linkedin,
                  size: 36,
                  color: linkedInLink != null ? AppColors.blue : AppColors.greyColor,
                ),
              ),
              const SizedBox(width: 35),
              /// GitHub
              InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: githubLink != null ? () => _launchURL(githubLink!) : null,
                child: FaIcon(
                  FontAwesomeIcons.github,
                  size: 36,
                  color: githubLink != null ? Theme.of(context).colorScheme.onSurface : AppColors.greyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
