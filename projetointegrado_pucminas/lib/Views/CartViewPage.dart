import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Models/Product.dart';
import 'package:projetointegrado_pucminas/Utils/CartinfoHeader.dart';
import 'package:projetointegrado_pucminas/Utils/ProductCatalog.dart';
import '../Controllers/ScreenNavController.dart';
import '../Models/Cart.dart';
import '../Models/Client.dart';
import '../Utils/CartBottomBar.dart';
import '../Utils/DefaultText.dart';

final GlobalKey<_CartViewPageState> cartViewPageKey =
    GlobalKey<_CartViewPageState>();

class CartViewPage extends StatefulWidget {
  CartViewPage() : super(key: cartViewPageKey);

  @override
  State<CartViewPage> createState() => _CartViewPageState();
}

class _CartViewPageState extends State<CartViewPage> {
  final navController = ScreenNavController();
  final List<Product> products = productCatalog;
  final Cart cart = Get.find<Cart>();
  final Client client = Get.find<Client>();

  // Define a callback function to update the header
  void updateInfo() {
    setState(() {});
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
                        // Add a second row here
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