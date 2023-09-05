import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobile_scanner/mobile_scanner_web.dart';

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
