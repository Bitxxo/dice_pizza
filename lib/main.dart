import 'package:dice_pizza/config/router/router_provider.dart';
import 'package:dice_pizza/config/theme/app_theme.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  runApp(const ProviderScope(child: DiceApp()));
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final AppTheme theme = ref.watch(themeProvider);
        final router = ref.read(routerProvider);
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: theme.getTheme(),
        );
      },
    );
  }
}
