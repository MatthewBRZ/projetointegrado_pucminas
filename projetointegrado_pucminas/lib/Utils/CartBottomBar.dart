import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:projetointegrado_pucminas/Models/Attendant.dart';
import 'package:projetointegrado_pucminas/Models/Client.dart';
import 'package:projetointegrado_pucminas/Models/Order.dart';
import '../Models/Cart.dart';
import '../Views/CartViewPage.dart';
import 'DefaultText.dart';

// First Initial Unique digCommand identifier
int digCommand = Random().nextInt(10000);

// Custom Widget to display info and Buttons at the bottom of the cartViewPage
class CartBottomBar extends StatelessWidget {
  final Cart cart = Get.find<Cart>();
  final Client client = Get.find<Client>();
  final Attendant attendant = Get.find<Attendant>();
  late Order order;
  late Order closeOrder;

  @override
  Widget build(BuildContext context) {
    // Initialize the Order on Screen build
    final Order order = Get.put(Order(
        client: client,
        attendant: attendant,
        cart: cart,
        digCommand: digCommand));

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
                    if (await order.createOrder()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color(0xFFC68958),
                        content: Text(
                          'Pedido registrado com sucesso. Seu carrinho foi limpo para novos pedidos.',
                        ),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color(0xFFC68958),
                        content: Text(
                          'Erro ao registrar pedido. Fale com um atendente.',
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
              DefaultText(
                  text: NumberFormat.currency(
                    locale: 'pt-BR',
                    symbol: 'R\$',
                  ).format(cart.getTotal()),
                  fontSize: 20),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (!await order.closeOrder()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Color(0xFFC68958),
                        content: Text(
                          'Sem pedidos para fechar comanda.',
                        ),
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      cartViewPageKey.currentState!.closeOrderMessage();
                      // Generate another digCommand identifier for the next Order
                      digCommand = Random().nextInt(10000);
                      order.digCommand = digCommand;
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
