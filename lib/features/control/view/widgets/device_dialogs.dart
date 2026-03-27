import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/features/control/model/device_model.dart';
import 'package:growiq/core/utils/plant_types.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class DeviceDialogs {
  static void showRenameDialog({
    required BuildContext context,
    required DeviceModel device,
  }) {
    final controller = TextEditingController(text: device.name);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.renameDevice),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.enterNewName,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<DeviceCubit>().renameDevice(
                  device.id,
                  controller.text.trim(),
                );
                Navigator.pop(dialogContext);
              }
            },
            child: Text(AppLocalizations.of(context)!.save),
          ),
        ],
      ),
    );
  }

  static void showDeleteDialog({
    required BuildContext context,
    required DeviceModel device,
    VoidCallback?
    onDeleted, // called after dialog closes (e.g. to pop detail view)
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.deleteDevice),
        content: Text("${AppLocalizations.of(context)!.deleteDeviceConfirmPrefix}${device.name}${AppLocalizations.of(context)!.deleteDeviceConfirmSuffix}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              context.read<DeviceCubit>().removeDevice(device.id);
              Navigator.pop(dialogContext); // close dialog only
              onDeleted?.call(); // caller handles page navigation
            },
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );
  }

  static String _getLocalizedPlantName(BuildContext context, String plantKey) {
    switch (plantKey.toLowerCase()) {
      case 'tomato': return AppLocalizations.of(context)!.tomato;
      case 'mint': return AppLocalizations.of(context)!.mint;
      case 'lettuce': return AppLocalizations.of(context)!.lettuce;
      case 'basil': return AppLocalizations.of(context)!.basil;
      case 'pepper': return AppLocalizations.of(context)!.pepper;
      case 'cucumber': return AppLocalizations.of(context)!.cucumber;
      case 'strawberry': return AppLocalizations.of(context)!.strawberry;
      case 'spinach': return AppLocalizations.of(context)!.spinach;
      default: return plantKey;
    }
  }

  static void showPlantSelectionDialog({
    required BuildContext context,
    required String deviceId,
  }) {
    String selectedCrop = "Tomato"; // Default crop

    final allCrops = PlantConfig.defaultThresholds.keys.toList();

    IconData getIconForCrop(String crop) {
      switch (crop) {
        case "Tomato": return Icons.eco;
        case "Mint": return Icons.spa;
        case "Lettuce": return Icons.grass;
        case "Basil": return Icons.local_florist;
        case "Pepper": return Icons.whatshot;
        case "Cucumber": return Icons.view_day;
        case "Strawberry": return Icons.favorite;
        case "Spinach": return Icons.nature_people;
        default: return Icons.local_florist;
      }
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? AppColors.black.withValues(alpha: 0.3)
                          : AppColors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.park_rounded,
                        size: 40,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.selectCropType,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      AppLocalizations.of(context)!.whatAreYouGrowing,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: 250, // Fixed height for scrollable grid
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 2.5,
                            ),
                        itemCount: allCrops.length,
                        itemBuilder: (context, index) {
                          final crop = allCrops[index];
                          final icon = getIconForCrop(crop);
                          final isSelected = selectedCrop == crop;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedCrop = crop;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                                    : Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icon,
                                    size: 20,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _getLocalizedPlantName(context, crop),
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? Theme.of(context).colorScheme.primary
                                          : Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3)),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.cancel,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              final thresholds =
                                  PlantConfig.defaultThresholds[selectedCrop] ??
                                  PlantConfig.defaultThresholds["Tomato"]!;
                              context.read<DeviceCubit>().setCropType(
                                deviceId,
                                thresholds,
                              );
                              Navigator.pop(dialogContext);

                              // After dismissing dialog, dismiss the scanner page if necessary
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.save,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void showAIModeConfirmDialog({
    required BuildContext context,
    required bool isTurningOn,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.black.withValues(alpha: 0.3)
                    : AppColors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isTurningOn
                      ? Theme.of(context).colorScheme.primary.withValues(alpha: 0.1)
                      : AppColors.orangeShade50.withValues(alpha: Theme.of(context).brightness == Brightness.dark ? 0.2 : 1.0),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isTurningOn ? Icons.auto_awesome : Icons.power_settings_new,
                  size: 40,
                  color: isTurningOn
                      ? Theme.of(context).colorScheme.primary
                      : AppColors.orangeShade700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isTurningOn ? AppLocalizations.of(context)!.enableAiModeQuestion : AppLocalizations.of(context)!.disableAiModeQuestion,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isTurningOn
                    ? AppLocalizations.of(context)!.enableAiModeDesc
                    : AppLocalizations.of(context)!.disableAiModeDesc,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.pop(dialogContext),
                      child: Text(
                        AppLocalizations.of(context)!.cancel,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: isTurningOn
                            ? AppColors.purpleShade600
                            : AppColors.orangeShade600,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        onConfirm();
                      },
                      child: Text(
                        isTurningOn ? AppLocalizations.of(context)!.enable : AppLocalizations.of(context)!.disable,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
