import 'package:flutter/material.dart';
import '../Controllers/ScreenNavController.dart';
import '../Utils/DefaultText.dart';

class OpenOrdersViewPage extends StatefulWidget {
  const OpenOrdersViewPage({super.key});

  @override
  State<OpenOrdersViewPage> createState() => _OpenOrdersViewPageState();
}

class _OpenOrdersViewPageState extends State<OpenOrdersViewPage> {
  final navController = ScreenNavController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {
                    navController.goBack();
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
                    SizedBox(
                      width: 250, // Adjust the width and height as needed.
                      height: 250,
                      child: Hero(
                        tag: 'bakeryLogo',
                        child: Image.asset(
                          'assets/images/bakery_logo.png', // Replace with your asset path.
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    DefaultText(text: 'PEDIDOS EM ABERTO', fontSize: 20),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Color(0xFFC68958),
                      thickness: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
