import 'package:flutter/material.dart';
import 'package:growiq/core/widgets/sensor_card.dart';
import 'package:growiq/core/utils/sensor_utils.dart';
import 'package:growiq/features/control/model/device_model.dart';

class HomeSensorGrid extends StatelessWidget {
  final DeviceModel device;

  const HomeSensorGrid({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    final sensorKeys = device.displaySensorKeys.take(2).toList();
    if (sensorKeys.isEmpty) return const SizedBox.shrink();

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: sensorKeys.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 15,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final key = sensorKeys[index];
        final value = double.tryParse(device.sensors[key].toString()) ?? 0;
        final thresholds = device.thresholds[key] ?? {};

        return AnimatedSensorCard(
          sensorName: key,
          sensorValue: value,
          unit: SensorUtils.getSensorUnit(key),
          icon: SensorUtils.getSensorIcon(key),
          minLimit: double.tryParse(thresholds['min']?.toString() ?? ''),
          maxLimit: double.tryParse(thresholds['max']?.toString() ?? ''),
        );
      },
    );
  }
}
