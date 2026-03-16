import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.contactUs),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.followUs,
              style: AppTextStyles.titleMedium(context),
            ),
            const SizedBox(height: 30),
            
            if (AppStrings.fbLink.isNotEmpty) ...[
              _buildContactItem(
                context,
                icon: FontAwesomeIcons.facebook,
                label: AppStrings.facebook,
                color: const Color(0xFF1877F2),
                onTap: () => _launchUrl(AppStrings.fbLink),
              ),
              const SizedBox(height: 16),
            ],
            
            if (AppStrings.instaLink.isNotEmpty) ...[
              _buildContactItem(
                context,
                icon: FontAwesomeIcons.instagram,
                label: AppStrings.instagram,
                color: const Color(0xFFE4405F),
                onTap: () => _launchUrl(AppStrings.instaLink),
              ),
              const SizedBox(height: 16),
            ],
            
            if (AppStrings.linkedInLink.isNotEmpty) ...[
              _buildContactItem(
                context,
                icon: FontAwesomeIcons.linkedin,
                label: AppStrings.linkedIn,
                color: const Color(0xFF0077B5),
                onTap: () => _launchUrl(AppStrings.linkedInLink),
              ),
              const SizedBox(height: 16),
            ],

            if (AppStrings.githubLink.isNotEmpty) ...[
              _buildContactItem(
                context,
                icon: FontAwesomeIcons.github,
                label: AppStrings.github,
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.white 
                    : Colors.black,
                onTap: () => _launchUrl(AppStrings.githubLink),
              ),
              const SizedBox(height: 16),
            ],

            if (AppStrings.websiteLink.isNotEmpty) ...[
              _buildContactItem(
                context,
                icon: FontAwesomeIcons.globe,
                label: AppStrings.website,
                color: Colors.teal,
                onTap: () => _launchUrl(AppStrings.websiteLink),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: Icon(icon, color: color, size: 28),
        title: Text(
          label,
          style: AppTextStyles.bodyText1(context).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}
