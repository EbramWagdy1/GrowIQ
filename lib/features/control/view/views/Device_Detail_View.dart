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
      backgroundColor: Colors.grey[50],
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 24,
                              ),
                              margin: const EdgeInsets.only(bottom: 25),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors:
                                      currentDevice.isHealthy
                                      ? [
                                          Colors.green.shade400,
                                          Colors.teal.shade500,
                                        ]
                                      : [
                                          Colors.orange.shade400,
                                          Colors.red.shade400,
                                        ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        currentDevice.isHealthy
                                        ? Colors.green.withValues(alpha: 0.3)
                                        : Colors.red.withValues(alpha: 0.3),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(
                                        alpha: 0.2,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      currentDevice.isHealthy
                                          ? Icons.health_and_safety
                                          : Icons.warning_amber_rounded,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentDevice.aiDiseaseMessage,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        if (currentDevice.ai['confidence'] != null &&
                                            !currentDevice.isHealthy)
                                          Text(
                                            currentDevice.aiConfidenceMessage,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white.withValues(
                                                alpha: 0.9,
                                              ),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        else
                                          Text(
                                            currentDevice.aiConfidenceMessage,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white.withValues(
                                                alpha: 0.9,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],

                          // Section Title
                          Row(
                            children: [
                              Icon(
                                Icons.sensors,
                                color: Colors.teal.shade700,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Environmental Overview",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // --- Legend / Hint Start ---
                          if (currentDevice.thresholds.isNotEmpty)
                            // --- Legend / Hint End ---
                            SensorGridView(
                              sensors: currentDevice.sensors,
                              thresholds: currentDevice.thresholds,
                            ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildLegendItem(Colors.blue, " Low"),
                                const SizedBox(width: 15),
                                _buildLegendItem(Colors.green, " Perfect"),
                                const SizedBox(width: 15),
                                _buildLegendItem(Colors.red, " High"),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          // Smart Controls Section
                          Row(
                            children: [
                              Icon(
                                Icons.dashboard_customize_rounded,
                                color: Colors.teal.shade700,
                                size: 24,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                "Smart Controls",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: currentDevice.isAiMode
                                    ? [
                                        Colors.deepPurple.shade400,
                                        Colors.purple.shade600,
                                      ]
                                    : [Colors.white, Colors.white],
                              ),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: currentDevice.isAiMode
                                      ? Colors.purple.withValues(alpha: 0.3)
                                      : Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              border: Border.all(
                                color: currentDevice.isAiMode
                                    ? Colors.transparent
                                    : Colors.grey.shade200,
                                width: 1.5,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: currentDevice.isAiMode
                                            ? Colors.white.withValues(
                                                alpha: 0.2,
                                              )
                                            : Colors.purple.withValues(
                                                alpha: 0.1,
                                              ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.auto_awesome,
                                        color: currentDevice.isAiMode
                                            ? Colors.white
                                            : Colors.purple.shade500,
                                        size: 24,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "AI Auto Mode",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            letterSpacing: 0.5,
                                            color:
                                                (currentDevice
                                                            .modes['ai_mode'] ==
                                                        true ||
                                                    currentDevice
                                                            .modes['ai_mode'] ==
                                                        1 ||
                                                    currentDevice
                                                            .modes['ai_mode'] ==
                                                        '1')
                                                ? Colors.white
                                                : Colors.black87,
                                          ),
                                        ),
                                        Text(
                                          "Let AI manage the farm",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:
                                                (currentDevice
                                                            .modes['ai_mode'] ==
                                                        true ||
                                                    currentDevice
                                                            .modes['ai_mode'] ==
                                                        1 ||
                                                    currentDevice
                                                            .modes['ai_mode'] ==
                                                        '1')
                                                ? Colors.white70
                                                : Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Switch(
                                  value: currentDevice.isAiMode,
                                  onChanged: (value) {
                                    DeviceDialogs.showAIModeConfirmDialog(
                                      context: context,
                                      isTurningOn: value,
                                      onConfirm: () {
                                        context.read<DeviceCubit>().toggleMode(
                                          currentDevice.id,
                                          'ai_mode',
                                          value,
                                        );
                                      },
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

  Widget _buildLegendItem(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
