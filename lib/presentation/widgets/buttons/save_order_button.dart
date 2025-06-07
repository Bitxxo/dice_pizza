import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/bloc/order_database/order_database_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveOrderButton extends StatelessWidget {
  final bool bigScreen;
  const SaveOrderButton(this.bigScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return bigScreen
        ? _SaveButton(bigScreen: bigScreen)
        : Tooltip(
          message: 'Guardar pedido',
          child: _SaveButton(bigScreen: bigScreen),
        );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.bigScreen});
  final bool bigScreen;

  @override
  Widget build(BuildContext context) {
    return FilledButton.icon(
      onPressed: () async {
        context.read<OrderDatabaseBloc>().add(SaveOrder(context));
        if (context.mounted) {
          final orderState = context.read<OrderContentsBloc>().state;
          final dbState = context.read<OrderDatabaseBloc>().state;
          if (orderState is OrderContentsError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(orderState.errorMessage)));
          } else if (dbState is OrderDatabaseError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(dbState.message)));
          } else if (orderState is OrderContentsActive) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('¡Guardado con éxito!')));
          }
        }
      },
      label: bigScreen ? Text('Guardar Pedido') : Text(''),
      icon: Icon(Icons.save, color: Colors.black),
    );
  }
}
