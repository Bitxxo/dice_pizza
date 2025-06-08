import 'package:dice_pizza/presentation/widgets/order_bottom_navigation.dart';
import 'package:flutter/material.dart';

class ExistingOrderScreen extends StatelessWidget {
  static const name = "EditOrder";
  const ExistingOrderScreen(this.child, {super.key});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: OrderBottomNavigation(),
        body: Center(child: child ?? Placeholder()),
      ),
    );
  }
}
