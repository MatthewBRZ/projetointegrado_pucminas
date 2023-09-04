import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/FirebaseData/firebase_options.dart';
import 'package:projetointegrado_pucminas/Views/HomeViewPage.dart';

void main() async {
  runApp(MyApp());

  // Set up firebase data
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final navigationController = ScreenNavController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialize controller navigator
      navigatorKey: navigationController.navigatorKey,
      // For debugging reasons do not show banner
      debugShowCheckedModeBanner: false,
      // Theme Color Set
      theme: ThemeData(
        primarySwatch: const MaterialColor(
          0xFFC68958, // Primary color value
          <int, Color>{
            50: Color(0xFFFDF7E6),
            100: Color(0xFFFBF0D0),
            200: Color(0xFFF8E8B9),
            300: Color(0xFFF6E0A3),
            400: Color(0xFFF4D88D),
            500: Color(0xFFC68958), // Primary color
            600: Color(0xFFF1CF60),
            700: Color(0xFFF0C84B),
            800: Color(0xFFF0C235),
            900: Color(0xFFEFCF1E),
          },
        ),
      ),
      home: const HomeViewPage(),
    );
  }
}
