import 'package:cloud_firestore/cloud_firestore.dart' as firestore;

class OrdersManager {
  Future<List<Map<String, dynamic>>> getOpenOrders() async {
    final orders = <Map<String, dynamic>>[];
    int lastOrder;

    try {
      final ordersDocRef = firestore.FirebaseFirestore.instance
          .collection('bakeryTicketSystemDB')
          .doc('Orders');

      final docSnapshot = await ordersDocRef.get();
      final data = docSnapshot.data() as Map<String, dynamic>;
      lastOrder = (data['latestOrderId']);

      for (int i = 0; i <= lastOrder; i++) {
        final ordersNumbers = firestore.FirebaseFirestore.instance
            .collection('/bakeryTicketSystemDB/')
            .doc('Orders')
            .collection(i.toString());

        final querySnapshot =
            await ordersNumbers.get(); // Wait for the query to complete

        final ordersList =
            querySnapshot.docs; // This contains a list of QueryDocumentSnapshot

        // You can iterate through the list and access the data for each document
        for (final doc in ordersList) {
          final data = doc.data() as Map<String, dynamic>;
          //final order = ordermodel.Order.fromMap(data); // Use factory constructor
          orders.add(data);
        }
      }
      print(orders);
    } catch (e) {
      print('Error fetching orders: $e');
    }

    return orders;
  }

  void getOngoingOrders() {}

  void getClosedOrders() {}
}
