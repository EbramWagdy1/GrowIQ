import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/features/control/model/device_model.dart';
import 'package:growiq/core/utils/plant_types.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';

class DeviceDialogs {
  static void showRenameDialog({
    required BuildContext context,
    required DeviceModel device,
  }) {
    final controller = TextEditingController(text: device.name);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text(AppStrings.renameDevice),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: AppStrings.enterNewName,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
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
            child: const Text(AppStrings.save),
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
        title: const Text(AppStrings.deleteDevice),
        content: Text("${AppStrings.deleteDeviceConfirmPrefix}${device.name}${AppStrings.deleteDeviceConfirmSuffix}"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.errorColor),
            onPressed: () {
              context.read<DeviceCubit>().removeDevice(device.id);
              Navigator.pop(dialogContext); // close dialog only
              onDeleted?.call(); // caller handles page navigation
            },
            child: const Text(AppStrings.delete, style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
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
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withValues(alpha: 0.1),
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
                      decoration: const BoxDecoration(
                        color: AppColors.tealShade50,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.park_rounded,
                        size: 40,
                        color: AppColors.tealShade700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      AppStrings.selectCropType,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      AppStrings.whatAreYouGrowing,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.black54,
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
                                    ? AppColors.tealShade50
                                    : AppColors.greyShade50,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.tealShade400
                                      : AppColors.greyShade200,
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
                                        ? AppColors.tealShade700
                                        : AppColors.greyShade600,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    crop,
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      color: isSelected
                                          ? AppColors.tealShade800
                                          : AppColors.greyShade700,
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
                                side: BorderSide(color: AppColors.greyShade300),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(dialogContext);
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            child: const Text(
                              AppStrings.cancel,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black54,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              backgroundColor: AppColors.tealShade600,
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
                            child: const Text(
                              AppStrings.save,
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
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.1),
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
                      ? AppColors.purpleShade50
                      : AppColors.orangeShade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isTurningOn ? Icons.auto_awesome : Icons.power_settings_new,
                  size: 40,
                  color: isTurningOn
                      ? AppColors.purpleShade700
                      : AppColors.orangeShade700,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isTurningOn ? AppStrings.enableAiModeQuestion : AppStrings.disableAiModeQuestion,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black87,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                isTurningOn
                    ? AppStrings.enableAiModeDesc
                    : AppStrings.disableAiModeDesc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.black54,
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
                      child: const Text(
                        AppStrings.cancel,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.black54,
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
                        isTurningOn ? AppStrings.enable : AppStrings.disable,
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
