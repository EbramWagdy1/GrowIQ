import 'package:flutter/material.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:url_launcher/url_launcher.dart';

class IntegrationsView extends StatelessWidget {
  const IntegrationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: CustomAppBar(title: l10n.integrations),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header section
              Text(
                l10n.integrationDesc,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              const SizedBox(height: 32),

              // Amazon Alexa Card
              _buildIntegrationCard(
                context,
                title: "Amazon Alexa",
                subtitle: l10n.alexaAnnouncement,
                icon: Icons.keyboard_voice,
                color1: const Color(0xFF00CAFF),
                color2: AppColors.primaryColor,
                onTap: () => _showAlexaInstructions(context, l10n),
              ),

              const SizedBox(height: 16),

              // Coming Soon Placeholder (Google Home)
              _buildIntegrationCard(
                context,
                title: "Google Home",
                subtitle: l10n.comingSoon,
                icon: Icons.home,
                color1: Colors.grey[400]!,
                color2: Colors.grey[600]!,
                onTap: null,
                isComingSoon: true,
              ),
              
              const SizedBox(height: 16),

              // Coming Soon Placeholder (Apple HomeKit)
              _buildIntegrationCard(
                context,
                title: "Apple HomeKit",
                subtitle: l10n.comingSoon,
                icon: Icons.apple,
                color1: Colors.grey[400]!,
                color2: Colors.grey[600]!,
                onTap: null,
                isComingSoon: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntegrationCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color1,
    required Color color2,
    required VoidCallback? onTap,
    bool isComingSoon = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: color1.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (!isComingSoon)
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }

  void _showAlexaInstructions(BuildContext context, AppLocalizations l10n) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  const Icon(Icons.keyboard_voice, color: Color(0xFF00CAFF), size: 32),
                  const SizedBox(width: 12),
                  Text(
                    l10n.alexaSupport,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildStep(context, 1, l10n.alexaStep1),
              _buildStep(context, 2, l10n.alexaStep2),
              _buildStep(context, 3, l10n.alexaStep3),
              _buildStep(context, 4, l10n.alexaStep4),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                  ),
                  child: Text(l10n.done, style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    final url = Uri.parse("https://alexa.amazon.com");
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.primaryColor),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text(
                    l10n.openAlexaApp,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStep(BuildContext context, int number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                // ignore: deprecated_member_use
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
