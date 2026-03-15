import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/device_card.dart';
import 'package:growiq/features/control/view/widgets/device_dialogs.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/features/control/view_model/device_state.dart';
import 'package:go_router/go_router.dart';

class ControlView extends StatelessWidget {
  const ControlView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocBuilder<DeviceCubit, DeviceState>(
          builder: (context, state) {
            if (state is DeviceLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is DeviceUpdated) {
              if (state.devices.isEmpty) {
                return const Center(child: Text(AppStrings.noDevicesFound));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.devices.length,
                itemBuilder: (context, index) {
                  final device = state.devices[index];
                  return GestureDetector(
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
                    child: Card(
                      elevation: 0,
                      child: DeviceCard(
                        deviceName: device.name,
                        isOnline: device.isOnline,
                        onRename: () => DeviceDialogs.showRenameDialog(
                          context: context,
                          device: device,
                        ),
                        onDelete: () => DeviceDialogs.showDeleteDialog(
                          context: context,
                          device: device,
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
