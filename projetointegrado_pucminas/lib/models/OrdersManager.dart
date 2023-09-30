import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class OrdersManager {
  // Get list of open orders in db
  Future<List<Map<String, dynamic>>> getOpenOrders() async {
    final orders = <Map<String, dynamic>>[];
    int lastOrder;

    try {
      final ordersDocRef = firestore.FirebaseFirestore.instance
          .collection('bakeryTicketSystemDB')
          .doc('Orders');

      final docSnapshot = await ordersDocRef.get();
      final data = docSnapshot.data() as Map<String, dynamic>;
      // Get the lastOrderId to know how many orders are open
      lastOrder = (data['latestOrderId']);
      // Loop through all orders to get info
      for (int i = 0; i <= lastOrder; i++) {
        final ordersNumbers = firestore.FirebaseFirestore.instance
            .collection('/bakeryTicketSystemDB/')
            .doc('Orders')
            .collection(i.toString());

        final querySnapshot = await ordersNumbers.get();
        final ordersList = querySnapshot.docs;
        // Get all data
        for (final doc in ordersList) {
          final data = doc.data() as Map<String, dynamic>;

          orders.add(data);
        }
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
    // Return Orders Open
    return orders;
  }

  void getOngoingOrders() {}

  void getClosedOrders() {}
}
