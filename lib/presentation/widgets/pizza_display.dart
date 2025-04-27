import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:flutter/material.dart';

class PizzaDisplay extends StatelessWidget {
  final Pizza pizza;
  const PizzaDisplay(this.pizza, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Column(
        children: [
          Text("Pizza"),
          pizza.ingredients.isEmpty
              ? const SizedBox()
              : Row(
                spacing: 20,
                children: [
                  Spacer(),
                  for (Ingredient i in pizza.ingredients)
                    i.isDouble
                        ? Text("Doble de ${i.type.value}")
                        : Text(i.type.value),
                  Spacer(),
                ],
              ),
        ],
      ),
    );
  }
}
