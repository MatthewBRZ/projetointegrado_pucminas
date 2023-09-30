import 'package:get/get.dart';
import 'CartItem.dart';

class Cart extends GetxController {
  final List<CartItem> items;
  List<CartItem> itemsPlaced = [];

  Cart({
    required this.items,
  });

  void addItem(CartItem newItem) {
    // Check if the item is already in the cart && check if any orders were placed to retrieve the list with the orders
    final existingIndex =
        items.indexWhere((cartItem) => cartItem.item == newItem.item);

    if (existingIndex != -1) {
      // If the item is already in the cart, update its quantity
      modifyItem(existingIndex, items[existingIndex].quantity + 1);
    } else {
      // If the item is not in the cart, add it as a new item
      items.add(newItem);
    }
  }

  // Remove an item from the cart based on its index
  void removeItem(int index) {
    if (index >= 0 && index < items.length) {
      items.removeAt(index);
    }
  }

  // Get a list of all items in the cart
  List<CartItem> getItems() {
    return items;
  }

  // Modify the quantity of an item in the cart based on its index
  void modifyItem(int index, int newQuantity) {
    if (index >= 0 && index < items.length && newQuantity >= 0) {
      items[index] = CartItem(
        item: items[index].item,
        quantity: newQuantity,
      );
    }

    if (newQuantity == 0) {
      removeItem(index);
    }
  }

  // Get cart Total price
  double getTotal() {
    double total = 0;

    items.forEach((item) {
      total = total + (item.quantity * item.item.price);
    });

    return total;
  }

  // Save the order items to cart
  void saveCart() {
    itemsPlaced.addAll(items);
  }
}
