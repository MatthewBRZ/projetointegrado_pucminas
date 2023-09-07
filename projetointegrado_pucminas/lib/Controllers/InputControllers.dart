import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputControllers extends GetxController {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController clientIdController = TextEditingController();

  void disposelogin() {
    userNameController.dispose();
    passwordController.dispose();
  }

  void disposeClient() {
    clientIdController.dispose();
  }
}
