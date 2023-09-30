import 'package:get/get.dart';

class Attendant extends GetxController {
  int id;
  String name;

  Attendant({
    required this.id,
    required this.name,
  });

  // Getters and setters
  int get getId => id;
  String get getName => name;

  set setId(int newId) {
    id = newId;
  }

  set setName(String newName) {
    name = newName;
  }

  // Reset to default
  reset() {
    id = 0;
    name = 'A ser definido';
  }
}
