import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/home/view_model/device_cubit.dart';
import 'package:growiq/core/utils/sensor_utils.dart';

class ActuatorSection extends StatelessWidget {
  final String deviceId;
  final Map<String, dynamic> actuators;

  const ActuatorSection({
    super.key,
    required this.deviceId,
    required this.actuators,
  });

  @override
  Widget build(BuildContext context) {
    const actuatorKeys = ['pump', 'light', 'fan'];

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
          children: actuatorKeys.map((actuator) {
            final isOn =
                actuators[actuator] == true ||
                actuators[actuator] == 1 ||
                actuators[actuator] == "1";

            return Container(
              width: (MediaQuery.of(context).size.width - 60) / 2,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    // ignore: deprecated_member_use
                    isOn ? Colors.teal.withOpacity(0.1) : Colors.grey[100],
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
                  Switch(
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
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
