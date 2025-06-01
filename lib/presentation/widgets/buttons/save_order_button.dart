import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
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
        context.read<OrderContentsBloc>().add(SaveOrderContents(context));
        await Future.delayed(Duration(milliseconds: 200));
        if (context.mounted) {
          final state = context.read<OrderContentsBloc>().state;
          if (state is OrderContentsError) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          } else if (state is OrderContentsActive) {
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
