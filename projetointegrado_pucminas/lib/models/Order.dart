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
  int lastOrderId;
  int digCommand;
  int localCommand;
  String obs = '';
  Status status;
  Cart cart;
  DateTime date = DateTime.now();
  double total;

  Order({
    required this.client,
    this.lastOrderId = 0,
    required this.attendant,
    required this.digCommand,
    this.localCommand = 0,
    this.obs = '',
    this.status = Status.NA_FILA,
    required this.cart,
    this.total = 0,
  });

  Future<bool> createOrder() async {
    try {
      // Retrieve the latest order number
      final latestOrderIdDoc = firestore.doc('bakeryTicketSystemDB/Orders/');
      final latestOrderIdSnapshot = await latestOrderIdDoc.get();
      lastOrderId = latestOrderIdSnapshot.exists
          ? latestOrderIdSnapshot.get('latestOrderId')
          : 1;

      // Save Cart
      cart.saveCart();

// Create the order with the incremented order number
      final orderCollection =
          firestore.collection('bakeryTicketSystemDB/').doc('Orders');
      final newOrderDoc =
          orderCollection.collection(lastOrderId.toString()).doc('Cart');
      await newOrderDoc.set({
        'client': client.getName,
        'orderId': lastOrderId,
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
      for (final cartItem in cart.itemsPlaced) {
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

      // Clear the cart for new orders
      cart.items.clear();

      // Update Cart View
      cartViewPageKey.currentState!.updateInfo();

      // Keep track of the first client Order Id
      if (firstId == 0) {
        firstId = lastOrderId;
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

  void deleteOrder() {}

  Future<bool> closeOrder() async {
    try {
      // Get a reference to the "Orders" document
      final ordersDocRef =
          FirebaseFirestore.instance.doc('bakeryTicketSystemDB/Orders');

      // Check if there is a order placed by Client
      if (firstId != 0) {
        cart.items.clear();
        cart.items.addAll(cart.itemsPlaced);
        cartViewPageKey.currentState!.updateInfo();
        print(total);

        // Increment the order number
        lastOrderId++;
        // Update the latest order number in Firestore
        final latestOrderIdDoc = firestore.doc('bakeryTicketSystemDB/Orders/');
        await latestOrderIdDoc.set({'latestOrderId': lastOrderId});

        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('Error closing orders: $error');
      return false;
    }
  }

  void editOrder() {}

  void updateStatus(Status newStatus) {
    status = newStatus;
  }
}
