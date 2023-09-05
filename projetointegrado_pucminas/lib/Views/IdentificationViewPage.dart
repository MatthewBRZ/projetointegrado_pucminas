import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:projetointegrado_pucminas/Controllers/QrCodeController.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Controllers/TablesController.dart';
import 'package:projetointegrado_pucminas/Utils/DefaultText.dart';

class IdentificationViewPage extends StatefulWidget {
  const IdentificationViewPage({super.key});

  @override
  State<IdentificationViewPage> createState() => _IdentificationViewPageState();
}

class _IdentificationViewPageState extends State<IdentificationViewPage> {
  final navController = ScreenNavController();
  final qrCodeController = QrCodeController();
  final TablesController tableController = TablesController();
  String qrCodeResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
                onTap: () {
                  navController.goBack();
                  dispose();
                },
                child: SizedBox(
                    width: 50, // Adjust the width and height as needed.
                    height: 50,
                    child: Image.asset(
                      'assets/images/backicon.png', // Replace with your asset path.
                      fit: BoxFit.contain,
                    ))) // Adjust the fit as needed.
            ,
            Center(
              child: Column(
                children: [
                  InkWell(
                      child: SizedBox(
                          width: 250, // Adjust the width and height as needed.
                          height: 250,
                          child: Hero(
                            tag: 'bakeryLogo',
                            child: Image.asset(
                              'assets/images/bakery_logo.png', // Replace with your asset path.
                              fit: BoxFit.contain,
                            ),
                          ))),
                  DefaultText(text: 'QUAL O SEU NOME?', fontSize: 20),
                ],
              ),
            ),
          ],
        )),
      )),
    );
  }
}
