import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/views/order_customer_view.dart';
import 'package:dice_pizza/presentation/views/order_payment_view.dart';
import 'package:dice_pizza/presentation/views/order_products_view.dart';
import 'package:dice_pizza/presentation/widgets/order_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  static const name = "CreateOrder";
  const OrderScreen(this.child, this.orderId, {super.key});
  final Widget? child;
  final int? orderId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider(
      create: (context) => OrderContentsBloc(),
      child: Scaffold(
        bottomNavigationBar: OrderBottomNavigation(currentView()),
        body: Center(child: child ?? Placeholder()),
      ),
    );
  }

  OrderNavigationViews currentView() {
    if (child is OrderCustomerView) {
      return OrderNavigationViews.customer;
    } else if (child is OrderPaymentView) {
      return OrderNavigationViews.payment;
    } else if (child is OrderProductsView) {
      return OrderNavigationViews.products;
    }
    return OrderNavigationViews.payment;
  }
}
