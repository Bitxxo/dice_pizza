import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerWidget {
  static const name = 'home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ref
            .watch(userProvider)
            .whenOrNull(
              data:
                  (data) => Text(
                    '¡Bienvenid@, ${data?.firstName ?? 'Usuario anónimo'}!',
                  ),
              loading: () => CircularProgressIndicator(),
            ),
        // actions: [SizedBox(width: 30)],
      ),
      floatingActionButton: FilledButton.tonalIcon(
        onPressed: () => context.go(RouterPaths.profile),
        label: Text('Perfil'),
        icon: Icon(Icons.person),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            FilledButton(
              onPressed: () {
                context.push(RouterPaths.products);
              },
              child: Text("Crear pedido"),
            ),
            FilledButton(
              onPressed: () {
                context.push(RouterPaths.database);
              },
              child: Text("Ver pedidos existentes"),
            ),
          ],
        ),
      ),
    );
  }
}
