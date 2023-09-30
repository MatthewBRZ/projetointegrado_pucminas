import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/Client.dart';
import '../Controllers/CartInfoHeaderController.dart';
import 'DefaultText.dart';

// Custom Widget to display info in the CartView Header portion of the page
class CartInfoHeader extends StatelessWidget {
  final CartInfoHeaderController cartInfoController =
      Get.find<CartInfoHeaderController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultText(
          text:
              '${Get.find<Client>().tableType}-${Get.find<Client>().tableNumber}',
          fontSize: 14,
        ),
        Row(
          children: [
            DefaultText(
                text: 'Comanda Dig.: ${cartInfoController.digCommand}',
                fontSize: 16),
            const Spacer(),
            DefaultText(
                text: 'Status: ${cartInfoController.orderStatus}',
                fontSize: 16),
          ],
        ),
        Row(
          children: [
            DefaultText(
                text: 'Comanda Local: ${cartInfoController.localCommand}',
                fontSize: 16),
            const Spacer(),
            DefaultText(
                text: 'Atendente: ${cartInfoController.attendantName}',
                fontSize: 16),
          ],
        ),
      ],
    );
  }
}
