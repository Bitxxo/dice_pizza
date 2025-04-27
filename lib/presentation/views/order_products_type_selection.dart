import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/widgets/buttons/pizza_type_button.dart';
import 'package:flutter/material.dart';

class OrderProductsTypeSelection extends StatelessWidget {
  const OrderProductsTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        for (PizzaTypes type in PizzaTypes.values)
          PizzaTypeButton(type, addPizza),
      ],
    );
  }

  void addPizza(Pizza pizza) {}
}
