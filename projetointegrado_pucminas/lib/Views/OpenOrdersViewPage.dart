import 'package:flutter/material.dart';
import 'package:projetointegrado_pucminas/Models/OrdersManager.dart';
import '../Controllers/ScreenNavController.dart';
import '../Models/Order.dart';
import '../Utils/DefaultText.dart';

// Open Orders Screen
class OpenOrdersViewPage extends StatefulWidget {
  const OpenOrdersViewPage({Key? key}) : super(key: key);

  @override
  State<OpenOrdersViewPage> createState() => _OpenOrdersViewPageState();
}

class _OpenOrdersViewPageState extends State<OpenOrdersViewPage> {
  final navController = ScreenNavController();
  late Future<List<Map<String, dynamic>>> ordersFuture;

  @override
  void initState() {
    super.initState();

    // load Open Orders
    ordersFuture = OrdersManager().getOpenOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  navController.goBack();
                },
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    'assets/images/backicon.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Hero(
                        tag: 'bakeryLogo',
                        child: Image.asset(
                          'assets/images/bakery_logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    DefaultText(text: 'PEDIDOS EM ABERTO', fontSize: 20),
                    const SizedBox(height: 20),
                    const Divider(
                      color: Color(0xFFC68958),
                      thickness: 10,
                    ),
                  ],
                ),
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: ordersFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    // Delayed empty message and navigation
                    Future.delayed(const Duration(seconds: 3), () {
                      if (mounted) {
                        // Check if the widget is still mounted
                        Navigator.of(context).pop(); // Go back to previous page
                      }
                    });
                    return const Center(
                      child: Text(
                        'A lista de pedidos está vazia. Você será redirecionado para a tela anterior.',
                      ),
                    );
                  } else {
                    final orders = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          final order = orders[index];
                          return Card(
                            color: const Color(0xFFC68958),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height: 100,
                                child: Stack(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          'PEDIDO: ${order['orderId'].toString()}'),
                                      subtitle: Text(
                                          'COMANDA DIG.: ${order['digCommand'].toString()}'),
                                      trailing: Text(
                                          'LOCAL: ${order['table'].toString()}'),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: IconButton(
                                        onPressed: () {
                                          // Delete the Order from database
                                          Order.deleteOrder(
                                              order['orderId'].toString());
                                          setState(() {
                                            orders.removeAt(index);
                                          });
                                        },
                                        icon: Image.asset(
                                          'assets/images/trashicon.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
