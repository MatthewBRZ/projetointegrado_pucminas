import 'package:flutter/material.dart';

import '../Models/Product.dart';

class ProductCatalog extends StatefulWidget {
  const ProductCatalog({super.key});

  @override
  State<ProductCatalog> createState() => _ProductCatalogState();
}

class _ProductCatalogState extends State<ProductCatalog> {
  final List<Product> products = [
    Product(
      name: 'Baguete',
      description: 'Pão tipo baguete / kg',
      price: 17.90,
    ),
    Product(
      name: 'Pudim de leite condensado',
      description: 'Pudim de leite condensado / kg',
      price: 47.80,
    ),
    Product(
      name: 'Coca-cola Lata',
      description: 'Lata de 350 ml',
      price: 4.50,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardápio Digital'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];

          return ListTile(
            title: Text(product.name),
            subtitle: Text(product.description),
            trailing: Text('R\$ ${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}
