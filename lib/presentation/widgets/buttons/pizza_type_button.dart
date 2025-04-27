import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:flutter/material.dart';

typedef AddProduct = void Function(Pizza pizza, BuildContext context);

class PizzaTypeButton extends StatelessWidget {
  const PizzaTypeButton(this.type, this.addPizza, {super.key});
  final PizzaTypes type;
  final AddProduct addPizza;

  @override
  Widget build(BuildContext context) {
    final Pizza pizza = Pizza();
    return SizedBox(
      width: 100,
      height: 100,
      child: InkWell(
        onTap: () => addPizza(pizza, context),
        child: Center(child: Text(type.name)),
      ),
    );
  }
}
