import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/device_card.dart';
import 'package:growiq/core/widgets/sensor_card.dart';
import 'package:growiq/core/utils/app_text_style.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/features/control/view_model/device_state.dart';
import 'package:growiq/features/control/view/widgets/device_dialogs.dart';
import 'package:growiq/core/utils/sensor_utils.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => HomeBodyState();
}

class HomeBodyState extends State<HomeBody> {
  final TextEditingController _addDeviceController = TextEditingController();
  int _selectedDeviceIndex = 0;

  @override
  void dispose() {
    _addDeviceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DeviceCubit, DeviceState>(
      listener: (context, state) {
        if (state is DeviceError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppColors.errorColor,
              action: SnackBarAction(
                label: AppStrings.retry,
                textColor: AppColors.white,
                onPressed: () => context.read<DeviceCubit>().refresh(),
              ),
            ),
          );
        }
        if (state is DeviceAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.farmAddedSuccess),
              backgroundColor: AppColors.successColor,
            ),
          );
          DeviceDialogs.showPlantSelectionDialog(
            context: context,
            deviceId: state.deviceId,
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: _buildBody(context, state),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, DeviceState state) {
    if (state is DeviceLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              AppStrings.checkingDevices,
              style: AppTextStyles.bodyText1(context).copyWith(fontSize: 14),
            ),
          ],
        ),
      );
    }

    if (state is DeviceUpdated && state.devices.isNotEmpty) {
      if (_selectedDeviceIndex >= state.devices.length) {
        _selectedDeviceIndex = 0;
      }

      final device = state.devices[_selectedDeviceIndex];
      final sensorKeys = device.displaySensorKeys;

      return SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                context.push(
                  '/device-detail',
                  extra: {
                    'deviceId': device.id,
                    'deviceName': device.name,
                    'isOnline': device.isOnline,
                  },
                );
              },
              child: DeviceCard(
                isOnline: device.isOnline,
                deviceName: device.name,
                title: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: _selectedDeviceIndex,
                    isExpanded: false,
                    icon: Icon(Icons.arrow_drop_down, color: Theme.of(context).colorScheme.primary),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedDeviceIndex = value;
                        });
                      }
                    },
                    items: List.generate(state.devices.length, (index) {
                      final currentDevice = state.devices[index];
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
                              (currentDevice.modes['ai_mode'] == true ||
                                      currentDevice.modes['ai_mode'] == 1 ||
                                      currentDevice.modes['ai_mode'] == '1')
                                  ? "AI Mode Active"
                                  : "Manual Mode",
                              style: AppTextStyles.bodyText1(context).copyWith(
                                fontSize: 12,
                                color: (currentDevice.modes['ai_mode'] == true ||
                                        currentDevice.modes['ai_mode'] == 1 ||
                                        currentDevice.modes['ai_mode'] == '1')
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
                onRename: () => DeviceDialogs.showRenameDialog(
                  context: context,
                  device: device,
                ),
                onChangePlant: () => DeviceDialogs.showPlantSelectionDialog(
                  context: context,
                  deviceId: device.id,
                ),
                onDelete: () => DeviceDialogs.showDeleteDialog(
                  context: context,
                  device: device,
                ),
              ),
            ),
            const SizedBox(height: 15),
            if (sensorKeys.isNotEmpty)
              Row(
                children: [
                  Expanded(
                    child: AnimatedSensorCard(
                      sensorName: sensorKeys[0],
                      sensorValue:
                          double.tryParse(
                            device.sensors[sensorKeys[0]].toString(),
                          ) ??
                          0,
                      unit: SensorUtils.getSensorUnit(sensorKeys[0]),
                      icon: SensorUtils.getSensorIcon(sensorKeys[0]),
                      minLimit: double.tryParse(
                        device.thresholds[sensorKeys[0]]?['min']?.toString() ??
                            '',
                      ),
                      maxLimit: double.tryParse(
                        device.thresholds[sensorKeys[0]]?['max']?.toString() ??
                            '',
                      ),
                    ),
                  ),
                  if (sensorKeys.length > 1) ...[
                    const SizedBox(width: 20),
                    Expanded(
                      child: AnimatedSensorCard(
                        sensorName: sensorKeys[1],
                        sensorValue:
                            double.tryParse(
                              device.sensors[sensorKeys[1]].toString(),
                            ) ??
                            0,
                        unit: SensorUtils.getSensorUnit(sensorKeys[1]),
                        icon: SensorUtils.getSensorIcon(sensorKeys[1]),
                        minLimit: double.tryParse(
                          device.thresholds[sensorKeys[1]]?['min']
                                  ?.toString() ??
                              '',
                        ),
                        maxLimit: double.tryParse(
                          device.thresholds[sensorKeys[1]]?['max']
                                  ?.toString() ??
                              '',
                        ),
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      );
    }

    // Default empty state / Add device
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.eco_outlined, size: 60, color: AppColors.greyColor),
          const SizedBox(height: 16),
          Text(
            AppStrings.noFarmsLinked,
            style: AppTextStyles.titleMedium(context).copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    AppStrings.addYourDevice,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _addDeviceController,
                    decoration: InputDecoration(
                      hintText: AppStrings.enterDeviceId,
                      prefixIcon: const Icon(Icons.qr_code_scanner),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_addDeviceController.text.isNotEmpty) {
                          context.read<DeviceCubit>().addDevice(
                            _addDeviceController.text.trim(),
                          );
                          _addDeviceController.clear();
                        }
                      },
                      child: const Text(
                        AppStrings.connect,
                        style: TextStyle(color: AppColors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (state is DeviceError) ...[
            const SizedBox(height: 16),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.errorColor),
            ),
          ],
        ],
      ),
    );
  }

  void showAddDeviceDialog() {
    _addDeviceController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.addNewFarm),
        content: TextField(
          controller: _addDeviceController,
          decoration: const InputDecoration(
            hintText: AppStrings.enterDeviceId,
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
            onPressed: () {
              if (_addDeviceController.text.isNotEmpty) {
                context.read<DeviceCubit>().addDevice(
                  _addDeviceController.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            child: const Text(AppStrings.connect, style: TextStyle(color: AppColors.white)),
          ),
        ],
      ),
    );
  }
}
