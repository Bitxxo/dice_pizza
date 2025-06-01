import 'package:dice_pizza/presentation/widgets/order_editing_scaffold.dart';
import 'package:dice_pizza/presentation/widgets/product/order_payment_products_list.dart';
import 'package:flutter/material.dart';

class OrderPaymentView extends StatelessWidget {
  static const name = 'Payment';
  const OrderPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return OrderEditingScaffold(
      title: 'Pago',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [OrderPaymentProductsList(), Spacer(), Placeholder()],
            ),
          ),
        ],
      ),
    );
  }
}
