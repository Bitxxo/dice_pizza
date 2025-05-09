import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/presentation/widgets/buttons/ingredient_type_button.dart';
import 'package:flutter/material.dart';

class OrderProductsIngredientSelection extends StatelessWidget {
  const OrderProductsIngredientSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          spacing: 20,
          children: [
            for (Ingredient i in Ingredient.values)
              IngredientTypeButton(i, toggleIngredient),
          ],
        ),
      ),
    );
  }

  void toggleIngredient(Ingredient ingredient, BuildContext context) {}
}
