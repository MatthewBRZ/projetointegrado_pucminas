import 'Product.dart';

class Menu {
  List<Product> items = [];

  void loadMenu(List<Product> products) {
    items = List.of(products);
  }

  void removeProduct(Product product) {
    items.remove(product);
  }

  void addProduct(Product product) {
    items.add(product);
  }

  void editProduct(Product oldProduct, Product newProduct) {
    final index = items.indexOf(oldProduct);
    if (index != -1) {
      items[index] = newProduct;
    }
  }
}
