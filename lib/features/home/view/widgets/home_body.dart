import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/features/control/view_model/device_state.dart';
import 'package:growiq/features/control/view/widgets/device_dialogs.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';
import 'home_loading_view.dart';
import 'home_empty_view.dart';
import 'device_selection_header.dart';
import 'home_sensor_grid.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => HomeBodyState();
}

class HomeBodyState extends State<HomeBody> {
  final TextEditingController _addDeviceController = TextEditingController();

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
                label: AppLocalizations.of(context)?.retry ?? 'Retry',
                textColor: AppColors.white,
                onPressed: () => context.read<DeviceCubit>().refresh(),
              ),
            ),
          );
        }
        if (state is DeviceAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)?.farmAddedSuccess ?? 'Success',
              ),
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
      return const HomeLoadingView();
    }

    if (state is DeviceUpdated && state.devices.isNotEmpty) {
      final selectedIndex = state.selectedDeviceIndex;
      final device = state.devices[selectedIndex];

      return SingleChildScrollView(
        child: Column(
          children: [
            DeviceSelectionHeader(
              devices: state.devices,
              selectedIndex: selectedIndex,
              onDeviceChanged: (index) {
                if (index != null) {
                  context.read<DeviceCubit>().selectDevice(index);
                }
              },
              onCardTap: () {
                context.push(
                  '/device-detail',
                  extra: {
                    'deviceId': device.id,
                    'deviceName': device.name,
                    'isOnline': device.isOnline,
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            HomeSensorGrid(device: device),
          ],
        ),
      );
    }

    // Default empty state / Add device
    return HomeEmptyView(
      controller: _addDeviceController,
      errorMessage: state is DeviceError ? state.message : null,
    );
  }

  void showAddDeviceDialog() {
    _addDeviceController.clear();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)?.addNewFarm ?? 'Add New Farm'),
        content: TextField(
          controller: _addDeviceController,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)?.enterDeviceId ?? 'ID',
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)?.cancel ?? 'Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              if (_addDeviceController.text.isNotEmpty) {
                context.read<DeviceCubit>().addDevice(
                  _addDeviceController.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            child: Text(
              AppLocalizations.of(context)?.connect ?? 'Connect',
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
