import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/widgets/pizza_display.dart';
import 'package:flutter/material.dart';

class OrderProductsList extends StatelessWidget {
  const OrderProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final pizza = Pizza(
      ingredients: {
        Ingredient(IngredientName.bacon),
        Ingredient(IngredientName.cebolla),
      },
    );
    return PizzaDisplay(pizza);
  }
}
