import 'package:flutter/material.dart';
import 'package:growiq/core/widgets/sensor_card.dart';
import 'package:growiq/core/utils/sensor_utils.dart';

class SensorGridView extends StatelessWidget {
  final Map<String, dynamic> sensors;

  const SensorGridView({
    super.key,
    required this.sensors,
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
          const SizedBox(height: 20),
        ],
      ],
    );
  }
}