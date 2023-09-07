import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Utils/BakeryInfoWidget.dart';
import 'package:projetointegrado_pucminas/Views/LoginViewPage.dart';
import 'package:projetointegrado_pucminas/Views/QrCodeViewPage.dart';

class HomeViewPage extends StatefulWidget {
  const HomeViewPage({super.key});

  @override
  _HomeViewPageState createState() => _HomeViewPageState();
}

class _HomeViewPageState extends State<HomeViewPage> {
  final navController = ScreenNavController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const Text(
                    'ACESSO',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'baskervville',
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                      onTap: () {
                        print('cliquei');
                        navController.navigateToScreen(LoginViewPage());
                      },
                      child: SizedBox(
                          width: 100, // Adjust the width and height as needed.
                          height: 100,
                          child: Hero(
                            tag: 'loginLogo',
                            child: Image.asset(
                              'assets/images/login_logo.png', // Replace with your asset path.
                              fit: BoxFit.contain,
                            ),
                          ))) // Adjust the fit as needed.
                  ,
                  const Text(
                    'ATENDIMENTO',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'baskervville',
                        fontWeight: FontWeight.bold),
                  ),
                  const Divider(
                    color: Color(0xFFC68958),
                    thickness: 10,
                  ),
                  const Hero(
                    tag: 'bakeryLogo',
                    child: CircleAvatar(
                      radius: 125,
                      backgroundImage:
                          AssetImage('assets/images/bakery_logo.png'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                  const Text(
                    'SISTEMA DE AUTOATENDIMENTO',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'baskervville',
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),

                  InkWell(
                      onTap: () {
                        navController.navigateToScreen(const QrCodeViewPage());
                        //navController.navigateToScreen(const CartViewPage());
                      },
                      child: SizedBox(
                          width: 100,
                          height: 100,
                          child: Image.asset(
                            'assets/images/scan_qrcode.png',
                            fit: BoxFit.contain,
                          ))),
                  const SizedBox(height: 15),
                  const Text(
                    'LER QR CODE',
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'baskervville',
                        fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 30),
                  // Call External Widget to fulfill info about bakery
                  BakeryInfoWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
