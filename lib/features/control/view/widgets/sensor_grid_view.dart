import 'package:flutter/material.dart';
import 'package:growiq/core/widgets/sensor_card.dart';
import 'package:growiq/core/utils/sensor_utils.dart';

class SensorGridView extends StatelessWidget {
  final Map<String, dynamic> sensors;
  final Map<String, dynamic> thresholds;

  const SensorGridView({
    super.key,
    required this.sensors,
    this.thresholds = const {},
  });

  @override
  Widget build(BuildContext context) {
    final keys = SensorUtils.getSortedSensorKeys(sensors);

    return Column(
      children: [
        for (int i = 0; i < keys.length; i += 2) ...[
          Row(
            children: [
              Expanded(
                child: AnimatedSensorCard(
                  sensorName: keys[i],
                  sensorValue:
                      double.tryParse(sensors[keys[i]].toString()) ?? 0,
                  unit: SensorUtils.getSensorUnit(keys[i]),
                  icon: SensorUtils.getSensorIcon(keys[i]),
                  minLimit: double.tryParse(
                    thresholds[keys[i]]?['min']?.toString() ?? '',
                  ),
                  maxLimit: double.tryParse(
                    thresholds[keys[i]]?['max']?.toString() ?? '',
                  ),
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
                    minLimit: double.tryParse(
                      thresholds[keys[i + 1]]?['min']?.toString() ?? '',
                    ),
                    maxLimit: double.tryParse(
                      thresholds[keys[i + 1]]?['max']?.toString() ?? '',
                    ),
                  ),
                )
              else
                const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}
