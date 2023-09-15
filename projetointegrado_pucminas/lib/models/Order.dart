import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:projetointegrado_pucminas/Controllers/CartInfoHeaderController.dart';
import '../Views/CartViewPage.dart';
import 'Client.dart';
import 'Attendant.dart';
import 'Cart.dart';
import 'Status.dart';

//Initialize firestore instance
final firestore = FirebaseFirestore.instance;
// Instantiate cartInfoHeader to update data
final cartInfoController = Get.find<CartInfoHeaderController>();

class Order {
  Client client = Get.find<Client>();
  Attendant attendant = Get.find<Attendant>();
  int orderId;
  int digCommand;
  int localCommand;
  String obs = '';
  Status status;
  final Cart cart;
  final DateTime date;
  double total;

  Order({
    required this.client,
    this.orderId = 0,
    required this.attendant,
    this.digCommand = 0,
    this.localCommand = 0,
    this.obs = '',
    this.status = Status.NA_FILA,
    required this.cart,
    required this.date,
    this.total = 0,
  });

  Future<bool> createOrder() async {
    try {
      // Retrieve the latest order number
      final latestOrderIdDoc = firestore.doc('bakeryTicketSystemDB/Orders/');
      final latestOrderIdSnapshot = await latestOrderIdDoc.get();
      orderId = latestOrderIdSnapshot.exists
          ? latestOrderIdSnapshot.get('latestOrderId')
          : 0;

      // Increment the order number
      orderId++;
      // Update the latest order number in Firestore
      await latestOrderIdDoc.set({'latestOrderId': orderId});

      //Generate a random digital Command
      digCommand = Random().nextInt(10000);

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
      });

      // Set itemIndex to 1
      final cartCollection = newOrderDoc.collection('CartItems');
      int itemIndex = 1;

      // Loop through cart items and add into DB
      for (final cartItem in cart.items) {
        final cartItemCollection = cartCollection.doc(itemIndex.toString());
        await cartItemCollection.set({
          'productId': cartItem.item.id,
          'quantity': cartItem.quantity,
        });
        itemIndex++;
      }

      //Update Cart Header Info
      cartInfoController.setDigCommand = digCommand.toString();
      cartInfoController.setLocalCommand = localCommand.toString();
      cartInfoController.setOrderStatus = status;
      cartInfoController.setAttendant = attendant.getName;

      // Update Cart View
      cartViewPageKey.currentState!.updateInfo();

      return true;
    } catch (e) {
      // Handle errors here
      print('Error creating order: $e');
      return false;
    }
  }

  void deleteOrder() {}

  Future<void> closeOrder() async {
    try {
      // Retrieve the latest order number
      final latestOrderIdDoc = firestore.doc('bakeryTicketSystemDB/Orders/');
      final latestOrderIdSnapshot = await latestOrderIdDoc.get();
      orderId = latestOrderIdSnapshot.exists
          ? latestOrderIdSnapshot.get('latestOrderId')
          : 0;

      // Get the document containing all orders
      final ordersDoc = await FirebaseFirestore.instance
          .doc('bakeryTicketSystemDB/Orders')
          .get();

      // Check if the document exists
      if (ordersDoc.exists) {
        final ordersData = ordersDoc.data() as Map<String, dynamic>;

        // Iterate through the orders
        ordersData.forEach((orderId, orderData) async {
          if (orderData['client'] == client.getName &&
              orderData['status'] == Status.NA_FILA.toString()) {
            // Calculate the total and update the status to "ENCERRADO"
            print(orderData['total']);
          }
        });
      }
    } catch (error) {
      print('Error closing orders: $error');
    }
  }

  void editOrder() {}

  void updateStatus(Status newStatus) {
    status = newStatus;
  }
}
