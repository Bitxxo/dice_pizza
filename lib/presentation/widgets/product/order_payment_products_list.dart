import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/product/product_price_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentProductsList extends StatelessWidget {
  const OrderPaymentProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<OrderContentsBloc>().state.products;
    final selected = context.watch<OrderContentsBloc>().state.selected;
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: size.width * 0.25,
        height: size.height * 0.7,
        child: Material(
          color: colors.tertiaryFixedDim,
          child: ListView(
            children: [
              for (int i = 0; i < products.length; i++)
                InkWell(
                  onTap:
                      () => context.read<OrderContentsBloc>().add(
                        PizzaSelected(i),
                      ),
                  child: ProductPriceTile(products[i]!, i == selected),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
