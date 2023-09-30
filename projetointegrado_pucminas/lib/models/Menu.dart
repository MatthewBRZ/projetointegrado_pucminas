import 'Product.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class Menu {
  List<Product> items = [];

  // Get the Menu from DataBase and return
  Future<List<Product>> loadMenu() async {
    try {
      final menuItemCollection = firestore.FirebaseFirestore.instance
          .collection('bakeryTicketSystemDB')
          .doc('Menu')
          .collection('Product');

      final querySnapshot = await menuItemCollection.get();
      final productList = querySnapshot.docs;

      items.clear(); // Clear the existing items list

      for (final doc in productList) {
        final data = doc.data() as Map<String, dynamic>;

        // Create a Product instance and add it to the items list
        final product = Product(
          name: data['name'] ?? '',
          description: data['description'] ?? '',
          price: (data['price'] as num?)?.toDouble() ?? 0.0,
          id: data['id'] ?? 0,
        );

        items.add(product);
      }
      return items; // Return the list of products
    } catch (e) {
      print('Error fetching menu items: $e');
      return []; // Return an empty list in case of an error
    }
  }

  // Remove products from menu List
  void removeProduct(Product product) {
    items.remove(product);
  }

  // add products to Menu List
  void addProduct(Product product) {
    items.add(product);
  }

  // edit products
  void editProduct(Product oldProduct, Product newProduct) {
    final index = items.indexOf(oldProduct);
    if (index != -1) {
      items[index] = newProduct;
    }
  }
}
