import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum OrderNavigationViews { customer, products, payment }

class OrderBottomNavigation extends StatelessWidget {
  const OrderBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: (index) => onDestinationSelected(index, context),
      currentIndex: getCurrentIndex(context),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cliente'),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_pizza),
          label: 'Productos',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: 'Pago'),
      ],
    );
  }

  int getCurrentIndex(BuildContext context) {
    final route = GoRouter.of(context).state.fullPath;
    switch (route) {
      case RouterPaths.customer:
        return 0;
      case RouterPaths.products:
        return 1;
      case RouterPaths.payment:
        return 2;
      default:
        return 1;
    }
  }

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
}
