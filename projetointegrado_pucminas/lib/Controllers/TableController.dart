import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:projetointegrado_pucminas/Models/Tables.dart';

class TableController {
  final controller = MobileScannerController();
  String tableNumber;
  String tableType;

  TableController({
    this.tableNumber = '',
    this.tableType = '',
  });

  bool checkTable(String scannedTable) {
    for (var table in BAKERY.values) {
      if (table.toString() == scannedTable) {
        tableNumber = table.toString().split('_').last;
        tableType = table.toString().split('_').first.split('.').last;
        return true;
      }
    }

    return false;
  }
}
