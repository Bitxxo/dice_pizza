import 'package:flutter/material.dart';

enum OrderComponents { customer, products, price }

class OrderNavigationDrawer extends StatelessWidget {
  const OrderNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
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
