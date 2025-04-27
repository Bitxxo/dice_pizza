import 'package:dice_pizza/presentation/views/order_products_type_selection.dart';
import 'package:dice_pizza/presentation/widgets/order_products_list.dart';
import 'package:flutter/material.dart';

class OrderProductsView extends StatelessWidget {
  static const name = 'Products';
  const OrderProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Añadir productos")),
      body: Center(
        child: Column(
          children: [OrderProductsList(), OrderProductsTypeSelection()],
        ),
      ),
    );
  }
}
