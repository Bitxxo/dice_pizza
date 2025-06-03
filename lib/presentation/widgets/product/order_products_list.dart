import 'package:animate_do/animate_do.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/shared/loading_box.dart';
import 'package:dice_pizza/presentation/widgets/product/pizza_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProductsList extends StatelessWidget {
  const OrderProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderContentsState state = context.watch<OrderContentsBloc>().state;
    final selected = state.selected;
    final products = state.products;
    if (state is OrderContentsLoading) {
      return _ProductsScrollView(
        products: products,
        selected: selected,
        loading: true,
      );
    } else {
      return _ProductsScrollView(products: products, selected: selected);
    }
  }
}

class _ProductsScrollView extends StatelessWidget {
  const _ProductsScrollView({
    required this.products,
    required this.selected,
    this.loading = false,
  });

  final Map<int, Pizza> products;
  final int selected;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Scrollbar(
        child: ListView(
          primary: true,
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          children: [
            for (int i = 0; i < products.length; i++)
              Row(
                children: [
                  loading
                      ? PizzaDisplay(
                        pizza: products[i]!,
                        index: i,
                        selected: i == selected,
                        loading: true,
                      )
                      : FadeInRight(
                        child: PizzaDisplay(
                          pizza: products[i]!,
                          index: i,
                          selected: i == selected,
                        ),
                      ),
                  SizedBox(width: 20),
                ],
              ),
            SizedBox(width: 100),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                SizedBox(width: 50),
                IconButton.filled(
                  tooltip: 'Añadir pizza',
                  onPressed:
                      () => context.read<OrderContentsBloc>().add(
                        PizzaAdded(Pizza()),
                      ),
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(width: 50),
          ],
        ),
      ),
    );
  }
}
