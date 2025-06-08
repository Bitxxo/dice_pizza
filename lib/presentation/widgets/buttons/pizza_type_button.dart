import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:flutter/material.dart';

typedef ChangeType = void Function(Pizza pizza, BuildContext context);

class PizzaTypeButton extends StatelessWidget {
  const PizzaTypeButton(
    this.type,
    this.addPizza,
    this.isCurrentType, {
    super.key,
  });
  final PizzaTypes type;
  final ChangeType addPizza;
  final bool isCurrentType;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isCurrentType ? colors.primary : colors.primaryContainer,
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
          onTap: () => addPizza(Pizza.fromType(type), context),
          child: Center(
            child: Text(
              type.value,
              style: TextStyle(
                color:
                    isCurrentType
                        ? colors.onPrimary
                        : colors.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
