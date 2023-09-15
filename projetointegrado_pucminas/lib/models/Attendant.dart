import 'package:get/get.dart';

class Attendant extends GetxController {
  int id;
  String name;

  Attendant({
    required this.id,
    required this.name,
  });

  int get getId => id;
  String get getName => name;

  set setId(int newId) {
    id = newId;
  }

  set setName(String newName) {
    name = newName;
  }
}
