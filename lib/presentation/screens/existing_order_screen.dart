import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/order_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExistingOrderScreen extends StatefulWidget {
  static const name = "CreateOrder";
  const ExistingOrderScreen(this.child, {super.key});
  final Widget? child;

  @override
  State<ExistingOrderScreen> createState() => _ExistingOrderScreenState();
}

class _ExistingOrderScreenState extends State<ExistingOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderContentsBloc(),
      child: Scaffold(
        bottomNavigationBar: OrderBottomNavigation(),
        body: Center(child: widget.child ?? Placeholder()),
      ),
    );
  }
}
