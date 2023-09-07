import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Controllers/TableController.dart';
import 'DefaultText.dart';

class CartInfoHeader extends StatelessWidget {
  CartInfoHeader({super.key});

  final tableInfo = Get.find<TableController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultText(
            text: '${tableInfo.tableType}-${tableInfo.tableNumber}',
            fontSize: 20),
        Row(
          children: [
            DefaultText(text: 'teste1', fontSize: 20),
            const Spacer(),
            DefaultText(text: 'teste2', fontSize: 20),
          ],
        ),
        Row(
          children: [
            DefaultText(text: 'teste3', fontSize: 20),
            const Spacer(),
            DefaultText(text: 'teste4', fontSize: 20),
          ],
        ),
      ],
    );
  }
}
