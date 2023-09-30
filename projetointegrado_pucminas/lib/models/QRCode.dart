import 'package:get/get.dart';
import 'Tables.dart';
import '../Models/Client.dart';

class QRCode {
  final String data;
  final Client client = Get.find<Client>();

  QRCode({
    required this.data,
  });

  // Validate the QR Code. If QR Code is valid, set client data related to table from the qr code readed
  bool validateQRCode(String scannedTable) {
    for (var table in BAKERY.values) {
      if (table.toString() == scannedTable) {
        client.setTableType = table.toString().split('_').first.split('.').last;
        client.setTableNumber = int.parse(table.toString().split('_').last);
        QRCode(data: scannedTable);

        return true;
      }
    }
    return false;
  }
}
