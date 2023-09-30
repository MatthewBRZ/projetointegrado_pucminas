import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Utils/CartinfoHeader.dart';
import '../Controllers/CartInfoHeaderController.dart';
import '../Controllers/InputControllers.dart';
import '../Controllers/ScreenNavController.dart';
import '../Controllers/TableController.dart';
import '../Models/Attendant.dart';
import '../Models/Cart.dart';
import '../Models/Client.dart';
import '../Utils/CartBottomBar.dart';
import '../Utils/DefaultText.dart';
import 'HomeViewPage.dart';

// Global State Key for external access to the View
final GlobalKey<_CartViewPageState> cartViewPageKey =
    GlobalKey<_CartViewPageState>();

// CartViewPage to display Cart information
class CartViewPage extends StatefulWidget {
  CartViewPage() : super(key: cartViewPageKey);

  @override
  State<CartViewPage> createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  // NavController for screen navigation
  final navController = ScreenNavController();

  // initializing GetX states managers
  Cart cart = Get.find<Cart>();
  Client client = Get.find<Client>();
  InputControllers inputControllers = Get.find<InputControllers>();
  TableController tableController = Get.find<TableController>();
  CartInfoHeaderController cartInfoHeaderController =
      Get.find<CartInfoHeaderController>();
  Attendant attendant = Get.find<Attendant>();

  // Callback function to update the header
  void updateInfo() {
    setState(() {});
  }

  // Close Order Function, executed Upon clicking "FECHAR COMANDA" from CartbottomBar
  void closeOrderMessage() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pagamento'),
          content: const Text(
              'Dirija-se ao caixa para pagamento. Obrigado pela preferência!'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Reset all getX States to default values
                client.setName = '';
                client.setTableNumber = 0;
                client.setTableType = '';
                cart.items.clear();
                cart.itemsPlaced.clear();
                inputControllers.clientIdController.clear();
                cartInfoHeaderController.reset();
                attendant.reset();

                Navigator.of(context).pop(); // Close the dialog
                // Go to main page
                navController.removeAllAndPush(const HomeViewPage());
              },
              child: const Text('Pagina Principal'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  navController.goBack();
                },
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    'assets/images/backicon.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: Hero(
                      tag: 'bakeryLogo',
                      child: Image.asset(
                        'assets/images/bakery_logo.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Image.asset(
                        width: 50,
                        height: 50,
                        'assets/images/cartIcon.png',
                      ),
                      const Spacer(),
                      Column(
                        children: [
                          DefaultText(text: 'CARRINHO', fontSize: 16),
                          DefaultText(text: '-', fontSize: 16),
                          DefaultText(text: client.name, fontSize: 16),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(
                        width: 50,
                        height: 50,
                        'assets/images/cartIcon.png',
                      ),
                    ],
                  ),
                  const Divider(
                    color: Color(0xFFC68958),
                    thickness: 10,
                  ),
                  CartInfoHeader(),
                  const Divider(
                    color: Color(0xFFC68958),
                    thickness: 10,
                  ),
                ],
              ),
            ),
            // Cart Items List
            Expanded(
              child: ListView.builder(
                itemCount: cart.items.length,
                itemBuilder: (context, index) {
                  final product = cart.items[index];
                  return Card(
                    color: const Color(0xFFC68958),
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(product.item.name),
                          subtitle: Text(product.item.description),
                          trailing: Text(NumberFormat.currency(
                            locale: 'pt-BR',
                            symbol: 'R\$',
                          ).format(product.item.price * product.quantity)),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  cart.modifyItem(
                                      index, cart.items[index].quantity - 1);
                                });
                              },
                              child: const Icon(
                                Icons.remove,
                                size: 32,
                              ),
                            ),
                            Container(
                              width: 32,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      Colors.black, // Specify the border color
                                  width: 1.0, // Specify the border width
                                ),
                                borderRadius: BorderRadius.circular(
                                    10.0), // Adjust the radius as needed
                              ),
                              child: Center(
                                child: DefaultText(
                                  text: product.quantity.toString(),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    cart.addItem(cart.items[index]);
                                    // cart.modifyItem(
                                    //     index, cart.items[index].quantity + 1);
                                  });
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 32,
                                )),
                          ],
                          // Add other widgets for the second row as needed
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            CartBottomBar(),
          ],
        ),
      ),
    );
  }
}
