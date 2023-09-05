import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Controllers/InputControllers.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Utils/DefaultText.dart';

class MenuViewPage extends StatefulWidget {
  const MenuViewPage({super.key});

  @override
  State<MenuViewPage> createState() => _MenuViewPageState();
}

class _MenuViewPageState extends State<MenuViewPage> {
  final navController = ScreenNavController();
  final inputController = InputControllers();
  List<String> items = [];

  @override
  void initState() {
    super.initState();

    // Simulate loading data
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        items = [
          "Item 1",
          "Item 2",
          "Item 3",
        ];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Prevent going back a page to avoid system disruption as the client already logged in
      onWillPop: () async {
        // Pop a message to the user to tell them they can't go back
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFFC68958),
          content: Text(
            'Não é possível voltar, fale com um atendente se necessário.',
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
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: Color(0xFFC68958),
                  thickness: 10,
                ),
                Center(
                  child: items.isEmpty
                      ? const CircularProgressIndicator() // Placeholder for loading state
                      : Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  leading: const Icon(Icons.restaurant_menu),
                                  title: Text(items[index]),
                                ),
                              );
                            },
                          ),
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
