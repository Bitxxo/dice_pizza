import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome,')),
      body: Center(
        child: FilledButton(
          onPressed: () {
            context.push(RouterPaths.products);
          },
          child: Text("Crear pedido"),
        ),
      ),
    );
  }
}
