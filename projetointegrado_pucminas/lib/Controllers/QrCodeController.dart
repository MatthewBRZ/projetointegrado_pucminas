import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeController {
  final MobileScannerController controller = MobileScannerController(
      detectionTimeoutMs: 500, detectionSpeed: DetectionSpeed.noDuplicates);

  void initController() {
    controller.start();
  }

  // Dispose the controller
  void dispose() {
    controller.dispose();
  }
}
