import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
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

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.25, // Wider than a square, like HomeKit tiles
      ),
      itemCount: actuatorKeys.length,
      itemBuilder: (context, index) {
        final actuator = actuatorKeys[index];
        final isOn =
            actuators[actuator] == true ||
            actuators[actuator] == 1 ||
            actuators[actuator] == "1";

        return GestureDetector(
          onTap: () {
            context.read<DeviceCubit>().toggleActuator(
              deviceId,
              actuator,
              !isOn,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isOn ? Colors.teal.shade500 : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: isOn
                      ? Colors.teal.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isOn
                            ? Colors.white.withValues(alpha: 0.2)
                            : Colors.grey.shade100,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        SensorUtils.getActuatorIcon(actuator),
                        color: isOn ? Colors.white : Colors.teal.shade600,
                        size: 26,
                      ),
                    ),
                    Icon(
                      isOn
                          ? Icons.power_settings_new
                          : Icons.power_settings_new_outlined,
                      color: isOn ? Colors.white : Colors.grey.shade300,
                      size: 20,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      actuator.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.5,
                        color: isOn ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isOn ? "Running" : "Off",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isOn ? Colors.white70 : Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
