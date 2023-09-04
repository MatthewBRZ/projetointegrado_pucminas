import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeController {
  // Set a global key for debbuging, and set controller
  final GlobalKey qrKey = GlobalKey(debugLabel: 'qr');
  late QRViewController controller;

  // Initilize controller to start listening and display result
  void initController(QRViewController controller) {
    this.controller = controller;
    this.controller.scannedDataStream.listen((scanData) {
      // Handle the scanned QR code
      print('Scanned QR code: $scanData');
    });
  }

  //Dispose the controller
  void dispose() {
    controller.dispose();
  }
}
