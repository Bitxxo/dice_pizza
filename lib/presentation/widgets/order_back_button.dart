import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderBackButton extends StatelessWidget {
  const OrderBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(7),
      child: IconButton.filled(
        onPressed: () {
          exitAlert(context);
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
