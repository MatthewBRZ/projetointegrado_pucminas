import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:projetointegrado_pucminas/Models/Tables.dart';

class TablesController {
  final controller = MobileScannerController();

  bool checkTable(String scannedTable) {
    for (var tableID in BAKERY.values) {
      if (tableID.toString() == scannedTable) {
        print(scannedTable);
        return true;
      }
    }

    return false;
  }
}
