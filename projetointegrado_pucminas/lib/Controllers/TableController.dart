import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:projetointegrado_pucminas/Models/Tables.dart';
import '../Models/Client.dart';

class TableController extends GetxController {
  final controller = MobileScannerController();
  final Client client = Get.find<Client>();
  // String tableNumber;
  // String tableType;

  bool checkTable(String scannedTable) {
    for (var table in BAKERY.values) {
      if (table.toString() == scannedTable) {
        client.setTableType = table.toString().split('_').first.split('.').last;
        client.setTableNumber = int.parse(table.toString().split('_').last);
        // tableNumber = table.toString().split('_').last;
        // tableType = table.toString().split('_').first.split('.').last;
        return true;
      }
    }

    return false;
  }
}
