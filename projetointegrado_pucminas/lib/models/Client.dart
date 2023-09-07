import 'package:get/get.dart';

class Client extends GetxController {
  String name;
  int tableNumber;
  String tableType;

  Client({
    required this.name,
    required this.tableNumber,
    required this.tableType,
  });

  // Getter for name
  String get getName => name;

  // Getter for tableNumber
  int get getTableNumber => tableNumber;

  // Getter for tableType
  String get getTableType => tableType;

  // Setter for name
  set setName(String newName) {
    name = newName;
  }

  // Setter for tableNumber
  set setTableNumber(int newTableNumber) {
    tableNumber = newTableNumber;
  }

  // Setter for tableType
  set setTableType(String newTableType) {
    tableType = newTableType;
  }
}
