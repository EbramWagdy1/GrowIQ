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
              Expanded(child: buildSquareCard()),
              const SizedBox(width: 20),
              Expanded(child: buildSquareCard()),
            ],
          ),
        ],
      ),
    );
  }
}
