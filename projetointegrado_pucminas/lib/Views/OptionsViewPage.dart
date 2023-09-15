import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Views/HomeViewPage.dart';
import 'package:projetointegrado_pucminas/Views/OpenOrdersViewPage.dart';

import '../Controllers/ScreenNavController.dart';
import '../Models/Auth.dart';
import '../Utils/DefaultText.dart';

class OptionsViewPage extends StatefulWidget {
  const OptionsViewPage({super.key});

  @override
  State<OptionsViewPage> createState() => _OptionsViewPageState();
}

class _OptionsViewPageState extends State<OptionsViewPage> {
  final navController = ScreenNavController();
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Prevent going back a page to avoid system disruption as the client already logged in
      onWillPop: () async {
        // Pop a message to the user to tell them they can't go back
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFFC68958),
          content: Text(
            'Uma vez logado não é possível voltar. Saia da conta.',
          ),
          duration: Duration(seconds: 3),
        ));
        // Prevent popping the current screen
        return false;
      },

      child: Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      DefaultText(text: 'PEDIDOS', fontSize: 20),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xFFC68958),
                        thickness: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            navController
                                .navigateToScreen(const OpenOrdersViewPage());
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultText(
                              text: 'PEDIDOS EM ABERTO',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultText(
                              text: 'EM ATENDIMENTO',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultText(
                              text: 'HISTÓRICO',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            navController.goBack();
                            navController
                                .navigateToScreen(const HomeViewPage());
                            auth.signOut();
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(300, 50),
                            backgroundColor: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DefaultText(
                              text: 'SAIR DA CONTA',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
