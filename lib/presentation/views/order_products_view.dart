import 'package:dice_pizza/presentation/widgets/order_editing_scaffold.dart';
import 'package:dice_pizza/presentation/widgets/product/order_products_type_selection.dart';
import 'package:dice_pizza/presentation/widgets/product/order_products_list.dart';
import 'package:flutter/material.dart';

class OrderProductsView extends StatelessWidget {
  static const name = 'Products';
  const OrderProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return OrderEditingScaffold(
      title: 'Añadir Pizzas',
      child: Column(
        spacing: 10,
        children: [OrderProductsList(), OrderProductsTypeSelection()],
      ),
    );
  }
}
