import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/home/view_model/device_cubit.dart';
import 'package:growiq/features/home/view_model/device_state.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController cameraController = MobileScannerController();

  bool isScanned = false;

  @override
  void initState() {
    super.initState();
    cameraController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<DeviceCubit, DeviceState>(
        listener: (context, state) {
          if (state is DeviceAddSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Farm Added Successfully!')),
            );
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          } else if (state is DeviceError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
            setState(() {
              isScanned = false;
            });
            cameraController.start();
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              /// 📷 Camera Preview
              MobileScanner(
                controller: cameraController,
                onDetect: (capture) async {
                  if (isScanned) return;

                  if (capture.barcodes.isNotEmpty) {
                    isScanned = true;

                    final code = capture.barcodes.first.rawValue ?? '---';

                    debugPrint('Scanned QR: $code');

                    await cameraController.stop();

                    if (!mounted) return;

                    context.read<DeviceCubit>().addDevice(code);
                  }
                },
              ),

              /// 🌑 Dark overlay
              Container(
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.5),
                ),
              ),

              /// 🟩 Scanner frame
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.greenAccent, width: 3),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),

              /// 🔦 Flash + Switch Camera Buttons
              Positioned(
                bottom: 80,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    /// Flash Button (v7 compatible)
                    ValueListenableBuilder<MobileScannerState>(
                      valueListenable: cameraController,
                      builder: (context, state, child) {
                        return IconButton(
                          onPressed: () => cameraController.toggleTorch(),
                          icon: Icon(
                            state.torchState == TorchState.on
                                ? Icons.flash_on
                                : Icons.flash_off,
                            color: Colors.white,
                            size: 36,
                          ),
                        );
                      },
                    ),

                    /// Switch Camera
                    IconButton(
                      onPressed: () => cameraController.switchCamera(),
                      icon: const Icon(
                        Icons.cameraswitch,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                  ],
                ),
              ),

              /// 🔙 Back Button
              Positioned(
                top: 60,
                left: 20,
                child: FloatingActionButton(
                  backgroundColor: Colors.greenAccent,
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              if (state is DeviceLoading)
                Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.greenAccent),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
