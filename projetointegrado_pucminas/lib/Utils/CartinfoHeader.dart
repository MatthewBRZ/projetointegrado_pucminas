import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/Client.dart';
import 'DefaultText.dart';

class CartInfoHeader extends StatelessWidget {
  CartInfoHeader({super.key});

  final Client client = Get.find<Client>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultText(
            text: '${client.tableType}-${client.tableNumber}', fontSize: 20),
        Row(
          children: [
            DefaultText(text: 'Comanda digital', fontSize: 20),
            const Spacer(),
            DefaultText(text: 'Status do pedido', fontSize: 20),
          ],
        ),
        Row(
          children: [
            DefaultText(text: 'Comanda Fisica', fontSize: 20),
            const Spacer(),
            DefaultText(text: 'Nome do atendente', fontSize: 20),
          ],
        ),
      ],
    );
  }
}
