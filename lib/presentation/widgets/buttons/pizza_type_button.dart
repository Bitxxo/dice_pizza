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
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 100,
        height: 50,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          hoverColor: Colors.amberAccent.shade100,
          splashColor: Colors.amber,
          onTap: () => addPizza(pizza, context),
          child: Center(child: Text(type.name)),
        ),
      ),
    );
  }
}
