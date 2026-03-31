import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/core/widgets/device_card.dart';
import 'package:growiq/features/control/model/device_model.dart';
import 'package:growiq/features/control/view/widgets/device_dialogs.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class DeviceSelectionHeader extends StatelessWidget {
  final List<DeviceModel> devices;
  final int selectedIndex;
  final ValueChanged<int?> onDeviceChanged;
  final VoidCallback? onRename;
  final VoidCallback? onChangePlant;
  final VoidCallback? onDelete;
  final VoidCallback? onCardTap;

  const DeviceSelectionHeader({
    super.key,
    required this.devices,
    required this.selectedIndex,
    required this.onDeviceChanged,
    this.onRename,
    this.onChangePlant,
    this.onDelete,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    if (devices.isEmpty) return const SizedBox.shrink();

    final device = devices[selectedIndex];

    return GestureDetector(
      onTap: onCardTap,
      child: DeviceCard(
        isOnline: device.isOnline,
        deviceName: device.name,
        title: DropdownButtonHideUnderline(
          child: DropdownButton<int>(
            value: selectedIndex,
            isExpanded: false,
            icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary),
            onChanged: onDeviceChanged,
            items: List.generate(devices.length, (index) {
              final currentDevice = devices[index];
              return DropdownMenuItem(
                value: index,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      currentDevice.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      currentDevice.isAiMode
                          ? AppLocalizations.of(context)!.aiModeActive
                          : AppLocalizations.of(context)!.manualMode,
                      style: AppTextStyles.bodyText1(context).copyWith(
                        fontSize: 12,
                        color: currentDevice.isAiMode
                            ? (Theme.of(context).brightness == Brightness.dark 
                                ? AppColors.white70 
                                : AppColors.primaryColor)
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        onRename: onRename ?? () => DeviceDialogs.showRenameDialog(context: context, device: device),
        onChangePlant: onChangePlant ?? () => DeviceDialogs.showPlantSelectionDialog(context: context, deviceId: device.id),
        onDelete: onDelete ?? () => DeviceDialogs.showDeleteDialog(context: context, device: device),
      ),
    );
  }
}
