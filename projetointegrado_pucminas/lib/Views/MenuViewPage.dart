import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projetointegrado_pucminas/Controllers/InputControllers.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import 'package:projetointegrado_pucminas/Models/CartItem.dart';
import 'package:projetointegrado_pucminas/Views/CartViewPage.dart';
import '../Models/Cart.dart';
import '../Models/Menu.dart';
import '../Models/Product.dart';
import '../Utils/DefaultText.dart';

// Client Menu page with all products listed on the Database
class MenuViewPage extends StatefulWidget {
  const MenuViewPage({super.key});

  @override
  State<MenuViewPage> createState() => _MenuViewPageState();
}

class _MenuViewPageState extends State<MenuViewPage> {
  final navController = ScreenNavController();
  final inputController = InputControllers();
  late List<Product> products;
  final Cart clientCart = Get.find<Cart>();
  late Future<List<Product>> menuFuture;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();

    // load Orders Function
    menuFuture = Menu().loadMenu();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // Prevent going back a page to avoid system disruption as the client is already logged in
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
                      SizedBox(
                        width: 250,
                        height: 250,
                        child: Hero(
                          tag: 'bakeryLogo',
                          child: Image.asset(
                            'assets/images/bakery_logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      DefaultText(text: 'CARDÁPIO DIGITAL', fontSize: 20),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Color(0xFFC68958),
                        thickness: 10,
                      ),
                    ],
                  ),
                ),
                // List of products loaded from the database
                FutureBuilder<List<Product>>(
                  future: menuFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      final catalogItem = snapshot.data!;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: catalogItem.length,
                          itemBuilder: (context, index) {
                            final product = catalogItem[index];
                            return Card(
                              color: const Color(0xFFC68958),
                              child: InkWell(
                                onTap: () {
                                  clientCart.addItem(
                                      CartItem(item: product, quantity: 1));

                                  navController.navigateToScreen(
                                    CartViewPage(),
                                  );
                                },
                                child: ListTile(
                                  title: Text(product.name),
                                  subtitle: Text(product.description),
                                  trailing: Text(NumberFormat.currency(
                                          locale: 'pt-BR', symbol: 'R\$')
                                      .format(product.price)),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
