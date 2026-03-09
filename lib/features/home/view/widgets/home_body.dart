import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/core/widgets/device_card.dart';
import 'package:growiq/core/widgets/sensor_card.dart';
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
              backgroundColor: Colors.red,
              action: SnackBarAction(
                label: 'Retry',
                textColor: Colors.white,
                onPressed: () => context.read<DeviceCubit>().refresh(),
              ),
            ),
          );
        }
        if (state is DeviceAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Farm added successfully!"),
              backgroundColor: Colors.green,
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
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              "Checking for devices...",
              style: TextStyle(color: Colors.grey),
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

      // Filter sensors: remove actuators
      final actuators = ['pump', 'light', 'fan'];
      final sensorKeys = device.sensors.keys
          .where((k) => !actuators.contains(k.toLowerCase()))
          .toList();

      // Prioritize Soil Temperature first, Humidity second
      sensorKeys.sort((a, b) {
        final aLower = a.toLowerCase();
        final bLower = b.toLowerCase();

        if (aLower.contains('soil temp') && !bLower.contains('soil temp')) {
          return -1;
        }
        if (!aLower.contains('soil temp') && bLower.contains('soil temp')) {
          return 1;
        }

        if (aLower.contains('humidity') && !bLower.contains('humidity')) {
          return -1;
        }
        if (!aLower.contains('humidity') && bLower.contains('humidity')) {
          return 1;
        }

        return a.compareTo(b);
      });

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
                    icon: const Icon(Icons.arrow_drop_down, color: Colors.teal),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _selectedDeviceIndex = value;
                        });
                      }
                    },
                    items: List.generate(state.devices.length, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(
                          state.devices[index].name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
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
          const Icon(Icons.eco_outlined, size: 60, color: Colors.grey),
          const SizedBox(height: 16),
          const Text(
            "No Farms Linked Yet",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
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
                    "Add Your Device",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _addDeviceController,
                    decoration: InputDecoration(
                      hintText: "Enter Device ID",
                      prefixIcon: const Icon(Icons.qr_code_scanner),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
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
                        "Connect",
                        style: TextStyle(color: Colors.white, fontSize: 16),
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
              style: const TextStyle(color: Colors.red),
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
        title: const Text("Add New Farm"),
        content: TextField(
          controller: _addDeviceController,
          decoration: const InputDecoration(
            hintText: "Enter Device ID",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            onPressed: () {
              if (_addDeviceController.text.isNotEmpty) {
                context.read<DeviceCubit>().addDevice(
                  _addDeviceController.text.trim(),
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Connect", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
