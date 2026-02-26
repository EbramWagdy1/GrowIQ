import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // rootBundle
import 'package:growiq/core/widgets/Device_card.dart';
import 'package:growiq/features/control/view/views/Device_Detail_View.dart';

class ControlView extends StatefulWidget {
  const ControlView({super.key});

  @override
  State<ControlView> createState() => _ControlViewState();
}

class _ControlViewState extends State<ControlView> {
  List<Map<String, dynamic>> devices = [];

  @override
  void initState() {
    super.initState();
    loadDevices();
  }

  Future<void> loadDevices() async {
    final String jsonString = await rootBundle.loadString(
      'assets/data/Devices.json',
    );
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      devices = jsonData.cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: devices.isEmpty
            ? const Center(child: CircularProgressIndicator())
            :ListView.builder(
  padding: const EdgeInsets.all(16),
  itemCount: devices.length,
  itemBuilder: (context, index) {
    final device = devices[index];
    return GestureDetector(
      onTap: () {
        // Navigate to DeviceDetailView (مثال)
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceDetailView(
              deviceName: device['name'] ?? 'Unknown',
              isOnline: device['isOnline'] ?? false,
            ),
          ),
        );
      },
      child: Card(
        elevation: 0,
        child: buildDeviceCard(
          deviceName: device['name'] ?? 'Unknown',
          isOnline: device['isOnline'] ?? false,
        ),
      ),
    );
  },
),
      ),
    );
  }
}
