import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/buttons/remove_product_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PizzaDisplay extends StatelessWidget {
  final Pizza pizza;
  final int index;
  final bool selected;
  const PizzaDisplay({
    required this.pizza,
    required this.index,
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color:
            selected
                ? colors.primaryContainer.withAlpha(170)
                : colors.onPrimaryContainer.withAlpha(50),
        border: Border.all(width: selected ? 2 : 1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: SizedBox(
        width: 350,
        height: 200,
        child: InkWell(
          onTap: () {
            context.read<OrderContentsBloc>().add(PizzaSelected(index));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(pizza.name),
                    Spacer(),
                    RemoveProductButton(index),
                  ],
                ),
                Spacer(),
                pizza.ingredients!.isEmpty
                    ? const SizedBox()
                    : Center(
                      child: GridView.count(
                        childAspectRatio:
                            pizza.ingredients!.length < 4
                                ? 2.5
                                : pizza.ingredients!.length > 6
                                ? 5
                                : 3.5,
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        children: [
                          for (Ingredient i in pizza.ingredients!)
                            Text(
                              i.value,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                            ),
                        ],
                      ),
                    ),
                Spacer(),
                Text('${pizza.price}€'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
