import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/views/order_products_type_selection.dart';
import 'package:dice_pizza/presentation/widgets/order_navigation_drawer.dart';
import 'package:dice_pizza/presentation/widgets/order_products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProductsView extends StatelessWidget {
  static const name = 'Products';
  const OrderProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Añadir productos")),
      drawer: OrderNavigationDrawer(),
      body: Center(
        child: BlocProvider(
          create: (context) => OrderContentsBloc(),
          child: Column(
            children: [OrderProductsList(), OrderProductsTypeSelection()],
          ),
        ),
      ),
    );
  }
}
