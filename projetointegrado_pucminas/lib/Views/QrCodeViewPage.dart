import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:projetointegrado_pucminas/Controllers/QrCodeController.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Controllers/TableController.dart';
import 'package:projetointegrado_pucminas/Utils/DefaultText.dart';
import 'package:projetointegrado_pucminas/Views/IdentificationViewPage.dart';

class QrCodeViewPage extends StatefulWidget {
  const QrCodeViewPage({super.key});

  @override
  State<QrCodeViewPage> createState() => _QrCodeViewPageState();
}

class _QrCodeViewPageState extends State<QrCodeViewPage> {
  final navController = ScreenNavController();
  final qrCodeController = QrCodeController();
  final TableController tableController = TableController();
  String qrCodeResult = '';

  @override
  void initState() {
    qrCodeController.initController();
    super.initState();
  }

  @override
  void dispose() {
    qrCodeController.dispose();
    super.dispose();
  }

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
                  DefaultText(text: 'ESCANEIE O QR CODE', fontSize: 20),
                  const SizedBox(height: 10),
                  // Sized box to scan QR CODE
                  SizedBox(
                    width: 250, // Adjust the width as needed.
                    height: 250, // Adjust the height as needed.
                    child: MobileScanner(
                      controller: qrCodeController.controller,
                      onDetect: (qrcode) {
                        // Get the last readable qr code and assess it
                        if (tableController.checkTable(qrcode
                            .barcodes[qrcode.barcodes.length - 1].rawValue
                            .toString())) {
                          navController.goBack();
                          navController.navigateToScreen(IdentificationViewPage(
                            qrCodeInfo: tableController,
                          ));
                        } else {
                          setState(() {
                            qrCodeResult = 'CÓDIGO INVÁLIDO';
                          });
                        }
                      },
                    ),
                  ),
                  Text(
                    qrCodeResult,
                    style: const TextStyle(
                        fontFamily: 'baskervville',
                        fontSize: 20,
                        color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        )),
      )),
    );
  }
}
