
import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? iconColor;

  const ProfileMenuItem({
    super.key,
    required this.text,
    required this.icon,
    this.trailing,
    this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50), // Pill shape
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: AppColors.greyColor.withValues(alpha: 0.3),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Using Flutter Icon to render the assets
            Icon(icon, size: 24, color: iconColor ?? AppColors.darkGreyIcon),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textColorPrimary,
                ),
              ),
            ),
            trailing ?? 
                const Icon(
                  Icons.arrow_forward_ios_rounded, 
                  size: 18,
                  color: AppColors.greyColor,
                ),
          ],
        ),
      ),
    );
  }
}
