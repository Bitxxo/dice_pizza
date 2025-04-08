import 'package:dice_pizza/presentation/widgets/order_navigation_drawer.dart';
import 'package:flutter/material.dart';

class OrderProductsView extends StatelessWidget {
  static const name = 'Products';
  const OrderProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Añadir productos")),
      drawer: OrderNavigationDrawer(),
      body: const Placeholder(),
    );
  }
}
