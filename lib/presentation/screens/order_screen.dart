import 'package:dice_pizza/presentation/widgets/order_navigation_drawer.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  static const name = "CreateOrder";
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nuevo pedido")),
      drawer: OrderNavigationDrawer(),
      body: const Center(child: Placeholder()),
    );
  }
}
