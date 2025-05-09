import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:flutter/material.dart';

class PizzaDisplay extends StatelessWidget {
  final Pizza pizza;
  final int index;
  const PizzaDisplay(this.pizza, this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 200,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Pizza"),
              pizza.ingredients.isEmpty
                  ? const SizedBox()
                  : Row(
                    spacing: 20,
                    children: [
                      Spacer(),
                      for (Ingredient i in pizza.ingredients)
                        Text(i.value, overflow: TextOverflow.visible),
                      Spacer(),
                    ],
                  ),
              Spacer(),
              Text('${pizza.price}€'),
            ],
          ),
        ),
      ),
    );
  }
}
