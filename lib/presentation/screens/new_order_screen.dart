import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/bloc/order_database/order_database_bloc.dart';
import 'package:dice_pizza/presentation/widgets/order_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewOrderScreen extends StatelessWidget {
  static const name = "CreateOrder";
  const NewOrderScreen(this.child, this.orderId, {super.key});
  final Widget? child;
  final int? orderId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrderDatabaseBloc()),
        BlocProvider(create: (context) => OrderContentsBloc()),
      ],
      child: Scaffold(
        bottomNavigationBar: OrderBottomNavigation(),
        body: Center(child: child ?? Placeholder()),
      ),
    );
  }
}
