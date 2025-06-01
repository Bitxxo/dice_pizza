import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentForm extends StatelessWidget {
  const PaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final price = context.watch<OrderContentsBloc>().state.totalPrice;
    return Column(
      children: [
        Row(children: [Text(price.toString())]),
      ],
    );
  }
}
