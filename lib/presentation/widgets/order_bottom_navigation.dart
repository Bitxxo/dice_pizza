import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum OrderNavigationViews { customer, products, payment }

class OrderBottomNavigation extends StatelessWidget {
  const OrderBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return BottomNavigationBar(
      //fixedColor: colors.inversePrimary,
      selectedItemColor: colors.inverseSurface,
      unselectedItemColor: colors.primary,
      type: BottomNavigationBarType.shifting,
      onTap: (index) => onDestinationSelected(index, context),
      currentIndex: getCurrentIndex(context),
      items: [
        BottomNavigationBarItem(
          backgroundColor: colors.surfaceContainerHighest,
          icon: Icon(Icons.kebab_dining),
          label: 'Ingredientes',
        ),
        BottomNavigationBarItem(
          backgroundColor: colors.surfaceContainerHighest,
          icon: Icon(Icons.local_pizza),
          label: 'Productos',
        ),
        BottomNavigationBarItem(
          backgroundColor: colors.surfaceContainerHighest,
          icon: Icon(Icons.attach_money),
          label: 'Pago',
        ),
      ],
    );
  }

  int getCurrentIndex(BuildContext context) {
    final route = GoRouter.of(context).state.fullPath;
    switch (route) {
      case RouterPaths.ingredients || RouterPaths.dbIngredients:
        return 0;
      case RouterPaths.products || RouterPaths.dbProducts:
        return 1;
      case RouterPaths.payment || RouterPaths.dbPayment:
        return 2;
      default:
        return 1;
    }
  }

  void onDestinationSelected(int index, BuildContext context) {
    if (getCurrentIndex(context) == index) return;
    final isDb = GoRouter.of(context).state.fullPath!.contains('database');
    switch (index) {
      case 0:
        context.push(
          isDb ? RouterPaths.dbIngredients : RouterPaths.ingredients,
        );
      case 1:
        context.push(isDb ? RouterPaths.dbProducts : RouterPaths.products);
      case 2:
        context.push(isDb ? RouterPaths.dbPayment : RouterPaths.payment);
    }
  }
}
