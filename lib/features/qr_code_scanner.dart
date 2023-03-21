import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({Key? key}) : super(key: key);

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code")),
      body: Column(
        children: [
          Expanded(child: _buildQrView(context)),
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Text(
                "RESULT: ${result?.code ?? "can't get data"}",
                style: TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: onPauseCamera,
            child: const Icon(Icons.pause),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: onFlashCamera,
            child: const Icon(Icons.bolt),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: onResumeCamera,
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: onFlipCamera,
            child: const Icon(Icons.cameraswitch),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.green,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 6,
        cutOutSize: 300,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void onPauseCamera() async {
    await controller?.pauseCamera();
  }

  void onFlashCamera() async {
    await controller?.toggleFlash();
    setState(() {});
  }

  void onResumeCamera() async {
    await controller?.resumeCamera();
  }

  void onFlipCamera() async {
    await controller?.flipCamera();
    setState(() {});
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
