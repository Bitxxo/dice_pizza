import 'package:flutter/material.dart';

class OrderPaymentView extends StatelessWidget {
  static const name = 'Payment';
  const OrderPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pago del pedido")),
      body: const Placeholder(),
    );
  }
}
