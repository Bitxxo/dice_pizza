import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/buttons/pizza_type_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProductsTypeSelection extends StatelessWidget {
  const OrderProductsTypeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 20,
      children: [
        for (PizzaTypes type in PizzaTypes.values)
          PizzaTypeButton(type, addPizza),
      ],
    );
  }

  void addPizza(Pizza pizza, BuildContext context) {
    context.read<OrderContentsBloc>().add(PizzaAdded(pizza));
  }
}
