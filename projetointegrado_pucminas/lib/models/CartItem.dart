import 'Product.dart';

class CartItem {
  final Product item;
  final int quantity;

  CartItem({
    required this.item,
    required this.quantity,
  });
}
