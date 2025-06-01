import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoveProductButton extends StatelessWidget {
  final int index;
  const RemoveProductButton(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return IconButton(
      tooltip: 'Eliminar pizza',
      hoverColor: Colors.red,
      color: colors.onPrimaryContainer,
      onPressed: () {
        context.read<OrderContentsBloc>().add(PizzaRemoved(index: index));
      },
      icon: Icon(
        Icons.cancel,
        // color: Colors.red
      ),
    );
  }
}
