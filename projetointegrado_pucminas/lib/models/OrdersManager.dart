import 'Order.dart';
import 'Status.dart';

class OrdersManager {
  final List<Order> orders;

  OrdersManager({
    required this.orders,
  });

  List<Order> getOpenOrders() {
    return orders.where((order) => order.status == Status.NA_FILA).toList();
  }

  List<Order> getOngoingOrders() {
    return orders
        .where((order) => order.status == Status.EM_ATENDIMENTO)
        .toList();
  }

  List<Order> getClosedOrders() {
    return orders.where((order) => order.status == Status.ENCERRADO).toList();
  }
}
