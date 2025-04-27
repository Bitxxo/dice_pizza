import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:flutter/material.dart';

typedef AddProduct = void Function(Pizza pizza);

class PizzaTypeButton extends StatelessWidget {
  const PizzaTypeButton(this.type, this.addPizza, {super.key});
  final PizzaTypes type;
  final AddProduct addPizza;

  @override
  Widget build(BuildContext context) {
    final Pizza pizza = Pizza();
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.lightBlue.shade100),
      child: SizedBox(
        width: 150,
        height: 150,
        child: InkWell(onTap: () => addPizza(pizza), child: Text(type.name)),
      ),
    );
  }
}
