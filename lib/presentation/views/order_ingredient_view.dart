import 'package:dice_pizza/presentation/widgets/order_editing_scaffold.dart';
import 'package:dice_pizza/presentation/widgets/order_editing/order_products_ingredient_selection.dart';
import 'package:dice_pizza/presentation/widgets/order_editing/order_products_list.dart';
import 'package:flutter/material.dart';

class OrderIngredientView extends StatelessWidget {
  static const name = 'Ingredient';
  const OrderIngredientView({super.key});

  @override
  Widget build(BuildContext context) {
    return OrderEditingScaffold(
      title: 'Modificar Ingredientes',
      child: Column(
        spacing: 10,
        children: [OrderProductsList(), OrderProductsIngredientSelection()],
      ),
    );
  }
}
