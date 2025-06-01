import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/buttons/ingredient_type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProductsIngredientSelection extends StatelessWidget {
  const OrderProductsIngredientSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final int selected = context.watch<OrderContentsBloc>().state.selected;
    final List<Ingredient>? currentIngredients =
        context
            .watch<OrderContentsBloc>()
            .state
            .products[selected]
            ?.ingredients;
    final bool isBigScreen = MediaQuery.sizeOf(context).width > 530;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: GridView.count(
          mainAxisSpacing: 30,
          crossAxisSpacing: 20,
          childAspectRatio: isBigScreen ? 4 : 2,
          crossAxisCount: isBigScreen ? 4 : 2,
          shrinkWrap: true,
          children: [
            for (Ingredient i in Ingredient.values)
              IngredientTypeButton(
                i,
                toggleIngredient,
                isIngredientPresent(i, currentIngredients),
              ),
          ],
        ),
      ),
    );
  }

  void toggleIngredient(Ingredient ingredient, BuildContext context) {
    if (context.read<OrderContentsBloc>().state.products.isEmpty) {
      context.read<OrderContentsBloc>().add(
        PizzaAdded(Pizza.fromType(PizzaTypes.margarita)),
      );
    }
    context.read<OrderContentsBloc>().add(IngredientToggled(ingredient));
  }

  bool isIngredientPresent(Ingredient i, List<Ingredient>? list) {
    if (list == null || list.isEmpty) return false;
    return list.where((value) => value == i).firstOrNull != null;
  }
}
