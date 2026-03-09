import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/control/view/widgets/actuator_section.dart';
import 'package:growiq/features/control/view/widgets/device_dialogs.dart';
import 'package:growiq/features/control/view/widgets/sensor_grid_view.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/features/control/view_model/device_state.dart';
import 'package:growiq/features/control/model/device_model.dart';

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
    return Scaffold(
      appBar: CustomAppBar(
        title: deviceName,
        actions: [
          BlocBuilder<DeviceCubit, DeviceState>(
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

              return PopupMenuButton<String>(
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
              );
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<DeviceCubit, DeviceState>(
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

            return currentDevice.isOnline
                ? Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          if (currentDevice.ai.isNotEmpty) ...[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 20),
                              decoration: BoxDecoration(
                                color:
                                    (currentDevice.ai['disease']
                                            ?.toString()
                                            .toLowerCase() ==
                                        'healthy')
                                    ? Colors.green.withOpacity(0.1)
                                    : Colors.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color:
                                      (currentDevice.ai['disease']
                                              ?.toString()
                                              .toLowerCase() ==
                                          'healthy')
                                      ? Colors.green
                                      : Colors.orange,
                                  width: 1.5,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    (currentDevice.ai['disease']
                                                ?.toString()
                                                .toLowerCase() ==
                                            'healthy')
                                        ? Icons.check_circle
                                        : Icons.warning,
                                    color:
                                        (currentDevice.ai['disease']
                                                ?.toString()
                                                .toLowerCase() ==
                                            'healthy')
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 30,
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          (currentDevice.ai['disease']
                                                      ?.toString()
                                                      .toLowerCase() ==
                                                  'healthy')
                                              ? 'Farm is Healthy'
                                              : 'Issue Detected: ${currentDevice.ai['disease'] ?? 'Unknown'}',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                (currentDevice.ai['disease']
                                                        ?.toString()
                                                        .toLowerCase() ==
                                                    'healthy')
                                                ? Colors.green[800]
                                                : Colors.orange[800],
                                          ),
                                        ),
                                        if (currentDevice.ai['confidence'] !=
                                                null &&
                                            currentDevice.ai['disease']
                                                    ?.toString()
                                                    .toLowerCase() !=
                                                'healthy')
                                          Text(
                                            'Confidence: ${(double.tryParse(currentDevice.ai['confidence'].toString()) ?? 0.0).toStringAsFixed(1)}%',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  (currentDevice.ai['disease']
                                                          ?.toString()
                                                          .toLowerCase() ==
                                                      'healthy')
                                                  ? Colors.green[800]
                                                  : Colors.orange[800],
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          SensorGridView(sensors: currentDevice.sensors),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  (currentDevice.modes['ai_mode'] == true ||
                                      currentDevice.modes['ai_mode'] == 1 ||
                                      currentDevice.modes['ai_mode'] == '1')
                                  ? Colors.purple.withOpacity(0.1)
                                  : Colors.grey[100],
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color:
                                    (currentDevice.modes['ai_mode'] == true ||
                                        currentDevice.modes['ai_mode'] == 1 ||
                                        currentDevice.modes['ai_mode'] == '1')
                                    ? Colors.purple
                                    : Colors.grey[300]!,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.auto_awesome,
                                      color:
                                          (currentDevice.modes['ai_mode'] ==
                                                  true ||
                                              currentDevice.modes['ai_mode'] ==
                                                  1 ||
                                              currentDevice.modes['ai_mode'] ==
                                                  '1')
                                          ? Colors.purple
                                          : Colors.grey,
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      "AI MODE",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            (currentDevice.modes['ai_mode'] ==
                                                    true ||
                                                currentDevice
                                                        .modes['ai_mode'] ==
                                                    1 ||
                                                currentDevice
                                                        .modes['ai_mode'] ==
                                                    '1')
                                            ? Colors.purple
                                            : Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                                Switch(
                                  value:
                                      (currentDevice.modes['ai_mode'] == true ||
                                      currentDevice.modes['ai_mode'] == 1 ||
                                      currentDevice.modes['ai_mode'] == '1'),
                                  activeColor: Colors.purple,
                                  onChanged: (value) {
                                    context.read<DeviceCubit>().toggleMode(
                                      currentDevice.id,
                                      'ai_mode',
                                      value,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
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
                  );
          },
        ),
      ),
    );
  }
}
