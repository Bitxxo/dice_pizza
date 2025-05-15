import 'package:dice_pizza/presentation/widgets/order_back_button.dart';
import 'package:dice_pizza/presentation/widgets/product/order_products_ingredient_selection.dart';
import 'package:dice_pizza/presentation/widgets/product/order_products_list.dart';
import 'package:flutter/material.dart';

class OrderIngredientView extends StatelessWidget {
  static const name = 'Ingredient';
  const OrderIngredientView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Modificar ingredientes"),
        leading: OrderBackButton(),
      ),
      body: Center(
        child: Column(
          spacing: 10,
          children: [OrderProductsList(), OrderProductsIngredientSelection()],
        ),
      ),
    );
  }
}
