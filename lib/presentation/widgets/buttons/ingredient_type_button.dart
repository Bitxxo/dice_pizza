import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:flutter/material.dart';

typedef AddIngredient =
    void Function(IngredientName name, BuildContext context);

class IngredientTypeButton extends StatelessWidget {
  const IngredientTypeButton(this.name, this.addIngredient, {super.key});
  final IngredientName name;
  final AddIngredient addIngredient;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.lightBlue.shade100),
      child: SizedBox(
        width: 150,
        height: 150,
        child: InkWell(
          onTap: () => addIngredient(name, context),
          child: Text(name.value),
        ),
      ),
    );
  }
}
