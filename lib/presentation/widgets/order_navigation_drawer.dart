import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum OrderComponents { customer, products, price }

class OrderNavigationDrawer extends StatelessWidget {
  const OrderNavigationDrawer({super.key});

  void onDestinationSelected(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.push(RouterPaths.customer);
      case 1:
        context.push(RouterPaths.products);
      case 2:
        context.push(RouterPaths.payment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      onDestinationSelected: (value) {
        onDestinationSelected(value, context);
      },
      children: [
        SizedBox(height: 200),
        NavigationDrawerDestination(
          icon: Icon(Icons.info_outline_rounded),
          label: Text("Cliente"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.kebab_dining_outlined),
          label: Text("Productos"),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.money),
          label: Text("Pago"),
        ),
      ],
    );
  }
}
