import 'package:flutter/material.dart';
import 'package:growiq/core/utils/app_assets.dart';
import 'package:lottie/lottie.dart';

Widget buildDeviceCard({required bool isOnline ,required String deviceName}) {
  return Container(
    height: 106,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          // ignore: deprecated_member_use
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: SizedBox(
          width: 70,
          height: 100,
          child: LottieBuilder.asset(
            Assets.lottieDevice,
            fit: BoxFit.contain,
          ),
        ),
        title:  Text(
          deviceName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          'Last sync: 2m ago',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 12,
          ),
        ),
        trailing: Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: isOnline ? const Color(0xFF00A86B) : Colors.red, // green if online, grey if offline
            shape: BoxShape.circle,
          ),
        ),
      ),
    ),
  );
}
