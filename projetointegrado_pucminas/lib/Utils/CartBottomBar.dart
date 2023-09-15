import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Models/Attendant.dart';
import 'package:projetointegrado_pucminas/Models/Client.dart';
import 'package:projetointegrado_pucminas/Models/Order.dart';
import '../Models/Cart.dart';
import 'DefaultText.dart';

class CartBottomBar extends StatelessWidget {
  final Cart cart = Get.find<Cart>();
  final Client client = Get.find<Client>();
  final Attendant attendant = Get.find<Attendant>();
  late Order newOrder;
  late Order closeOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: const BoxDecoration(
        color: Color(0xFFC68958),
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 2.0,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DefaultText(
                  text: 'ITENS: ${cart.items.length.toString()}', fontSize: 20),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    newOrder = Order(
                        client: client,
                        attendant: attendant,
                        cart: cart,
                        date: DateTime.now());
                    if (await newOrder.createOrder()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color(0xFFC68958),
                        content: Text(
                          'Pedido registrado com sucesso.',
                        ),
                        duration: Duration(seconds: 3),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultText(
                      text: 'REALIZAR PEDIDO',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DefaultText(text: cart.getTotal(), fontSize: 20),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    closeOrder = Order(
                        client: client,
                        attendant: attendant,
                        cart: cart,
                        date: DateTime.now());
                    closeOrder.closeOrder();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 50),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DefaultText(
                      text: 'FECHAR COMANDA',
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
