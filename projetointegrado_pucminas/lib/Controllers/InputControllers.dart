import 'package:flutter/material.dart';

class InputControllers {
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
