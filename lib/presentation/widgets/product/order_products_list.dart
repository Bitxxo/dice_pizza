import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/shared/error_message_display.dart';
import 'package:dice_pizza/presentation/widgets/shared/loading_box.dart';
import 'package:dice_pizza/presentation/widgets/product/pizza_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProductsList extends StatelessWidget {
  const OrderProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderContentsState state = context.watch<OrderContentsBloc>().state;
    final pizza = Pizza(ingredients: [Ingredient.bacon, Ingredient.pina]);

    if (state is OrderContentsLoading) {
      final placeholders = state.order.products.length;
      return Row(
        children: [for (int i = 0; i < placeholders; i++) LoadingBox()],
      );
    } else if (state is OrderContentsError) {
      return ErrorMessageDisplay(
        message: state.errorMessage,
        title: 'Error al cargar el pedido ',
      );
    } else {
      return SizedBox(
        height: 250,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          reverse: true,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          child: Row(
            spacing: 10,
            children: [
              for (int i = 0; i < state.order.products.length; i++)
                InkWell(
                  onTap: () {
                    context.read<OrderContentsBloc>().add(PizzaSelected(i));
                  },
                  child: PizzaDisplay(state.order.products[i], i),
                ),
            ],
          ),
        ),
      );
    }
  }
}
