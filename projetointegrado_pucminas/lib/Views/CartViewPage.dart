import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Controllers/InputControllers.dart';
import 'package:projetointegrado_pucminas/Utils/CartinfoHeader.dart';
import '../Controllers/ScreenNavController.dart';
import '../Utils/DefaultText.dart';

class CartViewPage extends StatefulWidget {
  const CartViewPage({super.key});

  @override
  State<CartViewPage> createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  final navController = ScreenNavController();
  final clientInput = Get.find<InputControllers>().clientIdController;

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
                    Row(
                      children: [
                        Image.asset(
                            width: 100,
                            height: 100,
                            'assets/images/cartIcon.png'),
                        const Spacer(),
                        //DefaultText(text: '', fontSize: 20),s
                        Column(
                          children: [
                            DefaultText(text: 'CARRINHO', fontSize: 20),
                            DefaultText(text: '-', fontSize: 20),
                            DefaultText(text: clientInput.text, fontSize: 20),
                          ],
                        ),
                        const Spacer(),
                        Image.asset(
                            width: 100,
                            height: 100,
                            'assets/images/cartIcon.png'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Color(0xFFC68958),
                      thickness: 10,
                    ),
                    // Custom Widget to display info
                    CartInfoHeader(),
                    const Divider(
                      color: Color(0xFFC68958),
                      thickness: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(children: [
                        DefaultText(text: 'ListScroll', fontSize: 16),
                      ]),
                    ),
                    Container(
                      child: DefaultText(text: 'Bottom Menu', fontSize: 16),
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
