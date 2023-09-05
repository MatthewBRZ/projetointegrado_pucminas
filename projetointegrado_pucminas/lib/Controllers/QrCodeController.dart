import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeController {
  final MobileScannerController controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates, detectionTimeoutMs: 1000);

  // Dispose the controller
  void dispose() {
    controller.dispose();
  }
}
