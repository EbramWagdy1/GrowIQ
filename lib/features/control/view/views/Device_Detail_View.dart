import 'package:flutter/material.dart';
import 'package:growiq/core/widgets/Sensor_card.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';

class DeviceDetailView extends StatelessWidget {
  final String deviceName;
  final bool isOnline;

  const DeviceDetailView({
    super.key,
    required this.deviceName,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: deviceName,
      ),
      body: Center(
        child: isOnline
            ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AnimatedSensorCard(
                              sensorName: 'Temperature',
                              sensorValue: 10,
                              unit: '°C',
                              icon: Icons.thermostat,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AnimatedSensorCard(
                              sensorName: 'Humidity',
                              sensorValue: 80,
                              unit: '%',
                              icon: Icons.water_drop,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                                  Row(
                        children: [
                          Expanded(
                            child: AnimatedSensorCard(
                              sensorName: 'Temperature',
                              sensorValue: 10,
                              unit: '°C',
                              icon: Icons.thermostat,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AnimatedSensorCard(
                              sensorName: 'Humidity',
                              sensorValue: 80,
                              unit: '%',
                              icon: Icons.water_drop,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                                  Row(
                        children: [
                          Expanded(
                            child: AnimatedSensorCard(
                              sensorName: 'Temperature',
                              sensorValue: 10,
                              unit: '°C',
                              icon: Icons.thermostat,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AnimatedSensorCard(
                              sensorName: 'Humidity',
                              sensorValue: 80,
                              unit: '%',
                              icon: Icons.water_drop,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                                  Row(
                        children: [
                          Expanded(
                            child: AnimatedSensorCard(
                              sensorName: 'Temperature',
                              sensorValue: 10,
                              unit: '°C',
                              icon: Icons.thermostat,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: AnimatedSensorCard(
                              sensorName: 'Humidity',
                              sensorValue: 80,
                              unit: '%',
                              icon: Icons.water_drop,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                    ],
                  ),
              ),
            )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.cancel,
                    color: Colors.red,
                    size: 80,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Device is Offline',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
      ),
    );
  }
}