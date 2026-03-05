import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/control/view/widgets/actuator_section.dart';
import 'package:growiq/features/control/view/widgets/device_dialogs.dart';
import 'package:growiq/features/control/view/widgets/sensor_grid_view.dart';
import 'package:growiq/features/home/view_model/device_cubit.dart';
import 'package:growiq/features/home/view_model/device_state.dart';
import 'package:growiq/features/home/model/device_model.dart';

class DeviceDetailView extends StatelessWidget {
  final String deviceId;
  final String deviceName;
  final bool isOnline;

  const DeviceDetailView({
    super.key,
    required this.deviceId,
    required this.deviceName,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, state) {
        DeviceModel? device;

        if (state is DeviceUpdated) {
          device = state.devices.firstWhere(
            (d) => d.id == deviceId,
            orElse: () => DeviceModel(
              id: deviceId,
              name: deviceName,
              isOnline: isOnline,
              ownerId: '',
            ),
          );
        }

        final currentDevice =
            device ??
            DeviceModel(
              id: deviceId,
              name: deviceName,
              isOnline: isOnline,
              ownerId: '',
            );

        return Scaffold(
          appBar: CustomAppBar(
            title: currentDevice.name,
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                onSelected: (value) {
                  if (value == 'rename') {
                    DeviceDialogs.showRenameDialog(
                      context: context,
                      device: currentDevice,
                    );
                  } else if (value == 'delete') {
                    DeviceDialogs.showDeleteDialog(
                      context: context,
                      device: currentDevice,
                      onDeleted: () =>
                          Navigator.pop(context), // go back after delete
                    );
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(value: 'rename', child: Text('Edit Name')),
                  PopupMenuItem(value: 'delete', child: Text('Delete Device')),
                ],
              ),
            ],
          ),
          body: Center(
            child: currentDevice.isOnline
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SensorGridView(sensors: currentDevice.sensors),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          ActuatorSection(
                            deviceId: currentDevice.id,
                            actuators: currentDevice.actuators,
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cancel, color: Colors.red, size: 80),
                      SizedBox(height: 20),
                      Text('Device is Offline', style: TextStyle(fontSize: 24)),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
