import 'package:dice_pizza/presentation/widgets/order_navigation_drawer.dart';
import 'package:flutter/material.dart';

class OrderCustomerView extends StatelessWidget {
  static const name = 'Customer';
  const OrderCustomerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Datos del cliente")),
      drawer: OrderNavigationDrawer(),
      body: const Placeholder(),
    );
  }
}
