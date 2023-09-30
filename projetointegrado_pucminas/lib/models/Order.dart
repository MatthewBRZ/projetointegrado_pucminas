import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Controllers/CartInfoHeaderController.dart';
import 'package:projetointegrado_pucminas/Controllers/ScreenNavController.dart';
import '../Views/CartViewPage.dart';
import 'Client.dart';
import 'Attendant.dart';
import 'Cart.dart';
import 'Status.dart';

//Initialize firestore instance
final firestore = FirebaseFirestore.instance;
// Instantiate cartInfoHeader to update data
final cartInfoController = Get.find<CartInfoHeaderController>();
final navController = ScreenNavController();
int firstId = 0;

class Order {
  Client client = Get.find<Client>();
  Attendant attendant = Get.find<Attendant>();
  int orderId;
  int digCommand;
  int localCommand;
  String obs = '';
  Status status;
  Cart cart;
  DateTime date;
  double total;

  Order({
    required this.client,
    this.orderId = 0,
    required this.attendant,
    required this.digCommand,
    this.localCommand = 0,
    this.obs = '',
    this.status = Status.NA_FILA,
    DateTime? date,
    required this.cart,
    this.total = 0,
  }) : date = date ?? DateTime.now();

  Future<bool> createOrder() async {
    try {
      // Retrieve the latest order number from db, if there is no orders put 1
      final latestOrderIdDoc = firestore.doc('bakeryTicketSystemDB/Orders/');
      final latestOrderIdSnapshot = await latestOrderIdDoc.get();
      orderId = latestOrderIdSnapshot.exists
          ? latestOrderIdSnapshot.get('latestOrderId')
          : 1;

      // Save Cart
      cart.saveCart();

// Create the order with the incremented order number
      final orderCollection =
          firestore.collection('bakeryTicketSystemDB/').doc('Orders');
      final newOrderDoc =
          orderCollection.collection(orderId.toString()).doc('Cart');
      await newOrderDoc.set({
        'client': client.getName,
        'orderId': orderId,
        'attendant': attendant.getName,
        'digCommand': digCommand,
        'localCommand': localCommand,
        'obs': obs,
        'status': status.toString(),
        'date': date,
        'total': cart.getTotal(),
        'table': '${client.getTableType} ${client.getTableNumber}',
      });

      // Set itemIndex to 1
      final cartCollection = newOrderDoc.collection('CartItems');
      int itemIndex = 1;

      // Loop through cart items and add into DB
      for (final cartItem in cart.itemsPlaced) {
        final cartItemCollection = cartCollection.doc(itemIndex.toString());
        await cartItemCollection.set({
          'productId': cartItem.item.id,
          'quantity': cartItem.quantity,
        });
        itemIndex++;
      }

      //Update Cart Header information
      cartInfoController.setDigCommand = digCommand.toString();
      cartInfoController.setLocalCommand = localCommand.toString();
      cartInfoController.setOrderStatus = status;
      cartInfoController.setAttendant = attendant.getName;

      // Clear the cart for new orders
      cart.items.clear();

      // Update Cart View Information
      cartViewPageKey.currentState!.updateInfo();

      // Keep track of the first client Order Id
      if (firstId == 0) {
        firstId = orderId;
      }

      // Keep track of the total money
      total = total + cart.getTotal();

      return true;
    } catch (e) {
      // Handle errors here
      print('Error creating order: $e');
      return false;
    }
  }

  Future<bool> closeOrder() async {
    try {
      // Check if there is a order placed by Client
      if (firstId != 0 && cart.itemsPlaced.isNotEmpty) {
        cart.items.clear();
        cart.items.addAll(cart.itemsPlaced);
        cartViewPageKey.currentState!.updateInfo();

        // Increment the order number
        orderId++;
        // Update the latest order number in Firestore
        final latestOrderIdDoc = firestore.doc('bakeryTicketSystemDB/Orders/');
        await latestOrderIdDoc.set({'latestOrderId': orderId});

        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error closing orders: $error');
      return false;
    }
  }

// Delete order from database
  static Future<void> deleteOrder(String orderId) async {
    try {
      firestore
          .collection('bakeryTicketSystemDB')
          .doc('Orders')
          .collection(orderId)
          .doc('Cart')
          .delete();
    } catch (e) {
      print('Error deleting order and its collection: $e');
    }
  }

  void editOrder() {}

  void updateStatus(Status newStatus) {
    status = newStatus;
  }
}
