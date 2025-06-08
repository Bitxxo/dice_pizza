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
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: ref
            .watch(userProvider)
            .whenOrNull(
              data:
                  (data) => Text(
                    '¡Bienvenid@, ${data?.firstName ?? 'Usuario anónimo'}!',
                  ),
              loading: () => CircularProgressIndicator(),
            ),
        actions: [
          FilledButton.icon(
            onPressed: () => context.go(RouterPaths.themes),
            label: Text('Cambiar apariencia'),
            icon: Icon(Icons.palette),
          ),
        ],
      ),
      floatingActionButton: FilledButton.icon(
        onPressed: () => context.go(RouterPaths.profile),
        label: Text('Perfil'),
        icon: Icon(Icons.person),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 30,
          children: [
            FilledButton(
              onPressed: () {
                context.push(RouterPaths.products);
              },
              child: SizedBox(
                width: width * 0.3,
                height: 60,
                child: Center(
                  child: Text(
                    "Crear pedido",
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            FilledButton.tonal(
              onPressed: () {
                context.push(RouterPaths.database);
              },
              child: SizedBox(
                width: width * 0.3,
                height: 60,
                child: Center(
                  child: Text(
                    "Ver pedidos existentes",
                    style: TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
