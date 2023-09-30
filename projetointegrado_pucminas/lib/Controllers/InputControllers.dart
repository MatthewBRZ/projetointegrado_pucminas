import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputControllers extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController clientIdController = TextEditingController();

  // Dispose Login Controllers
  void disposelogin() {
    userNameController.dispose();
    passwordController.dispose();
  }

  // Disspose Client Controler
  void disposeClient() {
    clientIdController.dispose();
  }
}
