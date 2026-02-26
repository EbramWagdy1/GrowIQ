import 'package:flutter/material.dart';
import 'package:growiq/core/widgets/Device_card.dart';
import 'package:growiq/core/widgets/Sensor_card.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          buildDeviceCard(isOnline: true , deviceName: 'farm1'),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: AnimatedSensorCard(
                sensorName: 'Temperature',
                sensorValue: 10,
                unit: '°C',
                icon: Icons.thermostat,
              
              )),
              const SizedBox(width: 20),
              Expanded(child: AnimatedSensorCard(
                sensorName: 'Humidity',
                sensorValue: 80,
                unit: '%',
                icon: Icons.water_drop,
                
              )),
            ],
          ),
        ],
      ),
    );
  }
}
