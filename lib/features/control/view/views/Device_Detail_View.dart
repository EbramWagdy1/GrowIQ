
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/widgets/Sensor_card.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/home/view_model/device_cubit.dart';
import 'package:growiq/features/home/view_model/device_state.dart';
import 'package:growiq/core/utils/sensor_utils.dart';
import 'package:growiq/features/home/model/device_model.dart';

class DeviceDetailView extends StatefulWidget {
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
  State<DeviceDetailView> createState() => _DeviceDetailViewState();
}

class _DeviceDetailViewState extends State<DeviceDetailView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, state) {
        DeviceModel? device;
        if (state is DeviceUpdated) {
          device = state.devices.firstWhere(
            (d) => d.id == widget.deviceId,
            orElse: () => DeviceModel(
              id: widget.deviceId,
              name: widget.deviceName,
              isOnline: widget.isOnline,
              ownerId: '',
            ),
          );
        }

        final currentDevice =
            device ??
            DeviceModel(
              id: widget.deviceId,
              name: widget.deviceName,
              isOnline: widget.isOnline,
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
                    _showRenameDialog(currentDevice);
                  } else if (value == 'delete') {
                    _showDeleteConfirmation(currentDevice);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'rename',
                    child: Row(
                      children: [
                        Icon(Icons.edit, size: 20, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('Edit Name'),
                      ],
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, size: 20, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Delete Device'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: Center(
            child: currentDevice.isOnline
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ..._buildSensorRows(currentDevice.sensors),
                          const SizedBox(height: 20),
                          const Divider(),
                          const SizedBox(height: 10),
                          _buildActuatorSection(
                            currentDevice.id,
                            currentDevice.sensors,
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
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

  void _showRenameDialog(DeviceModel device) {
    final controller = TextEditingController(text: device.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Rename Device"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Enter new name",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<DeviceCubit>().renameDevice(
                  device.id,
                  controller.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(DeviceModel device) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Delete Device"),
        content: Text("Are you sure you want to remove '${device.name}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              context.read<DeviceCubit>().removeDevice(device.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back from detail view
            },
            child: const Text("Delete", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
List<Widget> _buildSensorRows(Map<String, dynamic> sensors) {
  final List<Widget> rows = [];
  final actuators = ['pump', 'light', 'fan'];
  final keys = sensors.keys
      .where((k) => !actuators.contains(k.toLowerCase()))
      .toList();

  // Sort to prioritize Soil Temperature first, then Humidity, then others
  keys.sort((a, b) {
    final aLower = a.toLowerCase();
    final bLower = b.toLowerCase();

    // Soil Temperature first
    if (aLower.contains('soil temp') && !bLower.contains('soil temp')) return -1;
    if (!aLower.contains('soil temp') && bLower.contains('soil temp')) return 1;

    // Humidity second
    if (aLower.contains('humidity') && !bLower.contains('humidity')) return -1;
    if (!aLower.contains('humidity') && bLower.contains('humidity')) return 1;

    // Otherwise alphabetical
    return a.compareTo(b);
  });

  for (int i = 0; i < keys.length; i += 2) {
    rows.add(
      Row(
        children: [
          Expanded(
            child: AnimatedSensorCard(
              sensorName: keys[i],
              sensorValue: double.tryParse(sensors[keys[i]].toString()) ?? 0,
              unit: SensorUtils.getSensorUnit(keys[i]),
              icon: SensorUtils.getSensorIcon(keys[i]),
            ),
          ),
          const SizedBox(width: 20),
          if (i + 1 < keys.length)
            Expanded(
              child: AnimatedSensorCard(
                sensorName: keys[i + 1],
                sensorValue:
                    double.tryParse(sensors[keys[i + 1]].toString()) ?? 0,
                unit: SensorUtils.getSensorUnit(keys[i + 1]),
                icon: SensorUtils.getSensorIcon(keys[i + 1]),
              ),
            )
          else
            const Expanded(child: SizedBox()),
        ],
      ),
    );
    rows.add(const SizedBox(height: 20));
  }
  return rows;
}

  Widget _buildActuatorSection(String deviceId, Map<String, dynamic> sensors) {
    // Actuators are usually Pump, Light, Fan
    final actuators = ['pump', 'light', 'fan'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Controls",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: actuators.map((actuator) {
            final isOn =
                sensors[actuator] == true ||
                sensors[actuator] == 1 ||
                sensors[actuator] == "1";
            return Container(
              width: (MediaQuery.of(context).size.width - 60) / 2,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: isOn ? Colors.teal.withOpacity(0.1) : Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isOn ? Colors.teal : Colors.grey[300]!,
                  width: 1.5,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    SensorUtils.getActuatorIcon(actuator),
                    color: isOn ? Colors.teal : Colors.grey,
                  ),
                  Text(
                    actuator.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isOn ? Colors.teal : Colors.black87,
                    ),
                  ),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      value: isOn,
                      // ignore: deprecated_member_use
                      activeColor: Colors.teal,
                      onChanged: (value) {
                        context.read<DeviceCubit>().toggleActuator(
                          deviceId,
                          actuator,
                          value,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
