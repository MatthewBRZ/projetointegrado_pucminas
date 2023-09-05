import 'package:flutter/material.dart';

class ScreenNavController {
  //Create a global key identifier
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  //Create a single instance and set it up
  static final ScreenNavController _instance = ScreenNavController._internal();

  factory ScreenNavController() {
    return _instance;
  }
  // create a single instance
  ScreenNavController._internal();

  // Method to navigate to a new screen
  void navigateToScreen(Widget screen) {
    navigatorKey.currentState!.push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Method to pop the current screen and return to the previous screen
  void goBack() {
    navigatorKey.currentState!.pop();
  }
}
