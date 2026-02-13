import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:growiq/core/functions/navigation.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  MobileScannerController cameraController = MobileScannerController();

  @override
  void initState() {
    super.initState();
    cameraController.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: cameraController,
            onDetect: (barcodeCapture) {
              if (barcodeCapture.barcodes.isNotEmpty) {
                final code = barcodeCapture.barcodes.first.rawValue ?? '---';
                debugPrint('Scanned QR: $code');

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Scanned: $code')));
                customNavigate(context, '/Home');
              }
            },
          ),

          Container(
            // ignore: deprecated_member_use
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          ),

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

          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => cameraController.toggleTorch(),
                  icon: ValueListenableBuilder(
                    valueListenable: cameraController.torchState,
                    builder: (context, state, child) {
                      return Icon(
                        state == TorchState.on
                            ? Icons.flash_on
                            : Icons.flash_off,
                        color: Colors.white,
                        size: 36,
                      );
                    },
                  ),
                ),

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

          Positioned(
            top: 80,
            left: 20,
            child: FloatingActionButton(
              mini: false,
              backgroundColor: Colors.greenAccent,
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 32,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}
