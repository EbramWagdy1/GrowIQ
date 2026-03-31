import 'package:flutter/material.dart';
// Note: If you add Lottie later, uncomment the import and use Lottie.asset
// import 'package:lottie/lottie.dart';

/// Standard Error View for GrowIQ Application.
/// Used to display user-friendly error messages with an optional retry button.
class GrowIQErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? lottieAsset;
  final IconData? icon;

  const GrowIQErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.lottieAsset,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // If lottieAsset is provided, show lottie animation, else show icon
            if (lottieAsset != null)
              // Lottie.asset(lottieAsset!, height: 180)
              const SizedBox(height: 180, child: Placeholder()) // Placeholder for Lottie
            else
              Icon(
                icon,
                size: 80,
                // ignore: deprecated_member_use
                color: Theme.of(context).colorScheme.error.withOpacity(0.8),
              ),
            
            const SizedBox(height: 20),
            
            Text(
              'Something went wrong',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            
            const SizedBox(height: 8),
            
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            
            const SizedBox(height: 32),
            
            if (onRetry != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try Again'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
