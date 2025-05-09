import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:flutter/material.dart';

typedef ToggleIngredient = void Function(Ingredient name, BuildContext context);

class IngredientTypeButton extends StatelessWidget {
  const IngredientTypeButton(this.name, this.toggleIngredient, {super.key});
  final Ingredient name;
  final ToggleIngredient toggleIngredient;

  @override
  Widget build(BuildContext context) {
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
          onTap: () => toggleIngredient(name, context),
          child: Text(name.value),
        ),
      ),
    );
  }
}
