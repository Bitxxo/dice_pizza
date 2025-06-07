import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/buttons/pizza_type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProductsTypeSelection extends StatelessWidget {
  const OrderProductsTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isBigScreen = MediaQuery.sizeOf(context).width > 530;
    final int selected = context.watch<OrderContentsBloc>().state.selected;
    final String currentType =
        context.watch<OrderContentsBloc>().state.products[selected]?.name ?? '';
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
            for (PizzaTypes type in PizzaTypes.values)
              PizzaTypeButton(
                type,
                addPizza,
                currentType.toLowerCase() == type.name,
              ),
          ],
        ),
      ),
    );
  }

  void addPizza(Pizza pizza, BuildContext context) {
    if (context.read<OrderContentsBloc>().state.products.isEmpty) {
      context.read<OrderContentsBloc>().add(
        PizzaAdded(Pizza.fromType(PizzaTypes.margarita)),
      );
    }
    context.read<OrderContentsBloc>().add(PizzaEdited(pizza));
  }
}
