import 'Order.dart';

class OrdersHistory {
  final List<Order> orders;

  OrdersHistory({
    required this.orders,
  });

  List<Order> getByDate(DateTime date) {
    return orders.where((order) {
      return order.date.year == date.year &&
          order.date.month == date.month &&
          order.date.day == date.day;
    }).toList();
  }
}
