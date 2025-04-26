import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:dice_pizza/config/router/router_provider.dart';
import 'package:dice_pizza/presentation/views/order_customer_view.dart';
import 'package:dice_pizza/presentation/views/order_payment_view.dart';
import 'package:dice_pizza/presentation/views/order_products_view.dart';
import 'package:dice_pizza/presentation/widgets/order_navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  static const name = "CreateOrder";
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Widget view = switch (ref.watch(routerProvider).state.fullPath) {
      RouterPaths.products => OrderProductsView(),
      RouterPaths.payment => OrderPaymentView(),
      RouterPaths.customer || String() || null => OrderCustomerView(),
    };

    return Scaffold(drawer: OrderNavigationDrawer(), body: Center(child: view));
  }
}
