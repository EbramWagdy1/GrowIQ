import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/services/connectivity_service.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'dart:async';
import 'package:growiq/core/widgets/custom_Buttom.dart';

class AppConnectivityWrapper extends StatefulWidget {
  final Widget child;

  const AppConnectivityWrapper({super.key, required this.child});

  @override
  State<AppConnectivityWrapper> createState() => _AppConnectivityWrapperState();
}

class _AppConnectivityWrapperState extends State<AppConnectivityWrapper> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();

    final connectivityService = getIt<ConnectivityService>();

    // Initial check
    connectivityService.isConnected.then((value) {
      if (mounted) setState(() => _isConnected = value);
    });

    // Listen for connectivity changes
    _subscription = connectivityService.connectivityStream.listen((results) {
      final connected =
          results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);

      if (mounted) setState(() => _isConnected = connected);
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Widget _buildNoInternet() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              size: 100,
              color: AppColors.textColorPrimary,
            ),
            const SizedBox(height: 32),
            const Text(
              "Oops, No Internet Connection",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Make sure wifi or cellular data is turned on and then try again.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: CustomButtom(
                text: "Retry",
                onPressed: () async {
                  final isConnected =
                      await getIt<ConnectivityService>().isConnected;
                  if (mounted) setState(() => _isConnected = isConnected);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,
          if (!_isConnected) Positioned.fill(child: _buildNoInternet()),
        ],
      ),
    );
  }
}
