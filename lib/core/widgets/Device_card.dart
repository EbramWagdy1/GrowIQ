import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import 'package:lottie/lottie.dart';

class DeviceCard extends StatelessWidget {
  final bool isOnline;
  final String deviceName;
  final Widget? title;
  final VoidCallback? onRename;
  final VoidCallback? onChangePlant;
  final VoidCallback? onDelete;

  const DeviceCard({
    super.key,
    required this.isOnline,
    required this.deviceName,
    this.title,
    this.onRename,
    this.onChangePlant,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            // ignore: deprecated_member_use
            color: Theme.of(context).brightness == Brightness.dark 
                ? Colors.black26 
                // ignore: deprecated_member_use
                : Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: SizedBox(
              width: 70,
              height: 100,
              child: LottieBuilder.asset(
                Assets.lottieDevice,
                fit: BoxFit.contain,
              ),
            ),
            title:
                title ??
                Text(
                  deviceName,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: isOnline ? AppColors.onlineColor : Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, color: Colors.grey),
                  onSelected: (value) {
                    if (value == 'rename') {
                      onRename?.call();
                    } else if (value == 'change_plant') {
                      onChangePlant?.call();
                    } else if (value == 'delete') {
                      onDelete?.call();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'rename',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20, color: Colors.blue),
                          SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.editName),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'change_plant',
                      child: Row(
                        children: [
                          Icon(Icons.local_florist, size: 20, color: Colors.green),
                          SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.changePlant),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text(AppLocalizations.of(context)!.deleteDevice),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
