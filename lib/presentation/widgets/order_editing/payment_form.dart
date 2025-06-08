import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentForm extends StatelessWidget {
  const PaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final price = context.watch<OrderContentsBloc>().state.totalPrice;
    final paid = context.watch<OrderContentsBloc>().state.paid;
    return Column(
      spacing: 30,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Precio total: $price €'),
        FilledButton.tonal(
          onPressed: () {
            context.read<OrderContentsBloc>().add(TogglePaid());
          },
          child: Text(paid ? 'Marcar como no pagado' : 'Marcar como pagado'),
        ),

        // Spacer(),
      ],
    );
  }
}
