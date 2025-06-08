import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderBackButton extends StatelessWidget {
  const OrderBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderContentsBloc>().state;
    final isUnsaved = !state.saved;
    final hasContent = state.products.isNotEmpty;
    return Padding(
      padding: EdgeInsets.all(7),
      child: IconButton.filled(
        onPressed: () {
          if (isUnsaved && hasContent) {
            exitAlert(context);
          } else {
            context.go(RouterPaths.home);
          }
        },
        icon: Icon(Icons.arrow_back, size: 20, color: Colors.white),
      ),
    );
  }

  void exitAlert(BuildContext context) async {
    final exitDialog = AlertDialog(
      title: Text('¿Seguro que quieres salir?'),
      content: Text('Si sales ahora, los datos no serán guardados'),
      actions: [
        Row(
          children: [
            FilledButton(
              onPressed: () => context.go(RouterPaths.home),
              child: Text('Salir'),
            ),

            Spacer(),
            FilledButton(
              onPressed: () => context.pop(),
              child: Text('Cancelar'),
            ),
          ],
        ),
      ],
    );
    showDialog(context: context, builder: (context) => exitDialog);
  }
}
