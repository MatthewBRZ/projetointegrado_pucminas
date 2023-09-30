import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeController {
  //setup qr code controller
  final MobileScannerController controller = MobileScannerController(
      detectionTimeoutMs: 500, detectionSpeed: DetectionSpeed.noDuplicates);

// init Qr code controller
  void initController() {
    controller.start();
  }

  // Dispose the controller
  void dispose() {
    controller.dispose();
  }
}
