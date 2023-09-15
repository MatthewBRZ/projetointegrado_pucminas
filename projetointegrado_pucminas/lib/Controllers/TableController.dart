import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:projetointegrado_pucminas/Models/QRCode.dart';
import '../Models/Client.dart';

class TableController extends GetxController {
  final controller = MobileScannerController();
  final Client client = Get.find<Client>();

  bool checkTable(String scannedTable) {
    if (QRCode(data: scannedTable).validateQRCode(scannedTable)) {
      return true;
    }

    return false;
  }
}
