import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Controllers/InputControllers.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Controllers/TableController.dart';
import 'package:projetointegrado_pucminas/FirebaseData/firebase_options.dart';
import 'package:projetointegrado_pucminas/Models/Attendant.dart';
import 'package:projetointegrado_pucminas/Models/Cart.dart';
import 'package:projetointegrado_pucminas/Models/Client.dart';
import 'package:projetointegrado_pucminas/Controllers/CartInfoHeaderController.dart';
import 'package:projetointegrado_pucminas/Views/HomeViewPage.dart';

void main() async {
  // Set up firebase for web application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.web,
  );

  // Setting GetX states globally
  Get.put(Client(name: '', tableNumber: 0, tableType: ''));
  Get.put(Cart(items: []));
  Get.put(InputControllers());
  Get.put(TableController());
  Get.put(CartInfoHeaderController());
  Get.put(Attendant(id: 0, name: 'A ser definido'));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // Initializing nav controller
  final navigationController = ScreenNavController();

  // Root of the application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // initialize controller navigator
      navigatorKey: navigationController.navigatorKey,
      // Hide Debbuging Banner
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
      // HomeViewPage as the app main page
      home: const HomeViewPage(),
    );
  }
}
