import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/order_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderScreen extends StatelessWidget {
  static const name = "CreateOrder";
  const OrderScreen(this.child, this.orderId, {super.key});
  final Widget? child;
  final int? orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderContentsBloc(),
      child: Scaffold(
        bottomNavigationBar: OrderBottomNavigation(),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Center(child: child ?? Placeholder()),
        ),
      ),
    );
  }
}
