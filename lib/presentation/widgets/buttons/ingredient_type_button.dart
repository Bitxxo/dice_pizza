import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:flutter/material.dart';

typedef ToggleIngredient = void Function(Ingredient name, BuildContext context);

class IngredientTypeButton extends StatelessWidget {
  const IngredientTypeButton(
    this.name,
    this.toggleIngredient,
    this.isPresent, {
    super.key,
  });
  final Ingredient name;
  final bool isPresent;
  final ToggleIngredient toggleIngredient;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isPresent ? colors.primary : colors.primaryContainer,
        border: Border.all(),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        hoverColor: colors.primaryContainer,
        splashColor: colors.onPrimaryContainer.withAlpha(10),
        onTap: () => toggleIngredient(name, context),
        child: Center(
          child: Text(
            name.value,
            style: TextStyle(
              color: isPresent ? colors.onPrimary : colors.onPrimaryContainer,
            ),
          ),
        ),
      ),
    );
  }
}
