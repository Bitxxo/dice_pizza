import 'package:dice_pizza/presentation/widgets/product/order_products_type_selection.dart';
import 'package:dice_pizza/presentation/widgets/order_back_button.dart';
import 'package:dice_pizza/presentation/widgets/product/order_products_list.dart';
import 'package:flutter/material.dart';

class OrderProductsView extends StatelessWidget {
  static const name = 'Products';
  const OrderProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Añadir productos"),
        toolbarHeight: 50,
        leading: OrderBackButton(),
      ),
      body: Center(
        child: Column(
          spacing: 10,
          children: [OrderProductsList(), OrderProductsTypeSelection()],
        ),
      ),
    );
  }
}
