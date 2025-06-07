import 'package:dice_pizza/presentation/providers/dummyapi/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeChangerScreen extends ConsumerWidget {
  const ThemeChangerScreen({super.key});
  static const nombre = 'Theme Screen';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool modoOscuro = ref.watch(themeProvider).modoOscuro;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.surfaceContainerHighest,
      appBar: AppBar(
        title: const Text('Modificar Tema'),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(themeProvider.notifier).toggleDarkMode();
            },
            icon:
                modoOscuro
                    ? const Icon(Icons.dark_mode_outlined)
                    : const Icon(Icons.light_mode_outlined),
          ),
        ],
      ),
      body: const _ThemeChangerView(),
    );
  }
}

class _ThemeChangerView extends ConsumerWidget {
  const _ThemeChangerView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Color> colors = ref.watch(colorsProvider);
    final int seleccionado = ref.watch(themeProvider).selected;
    return ListView.builder(
      itemCount: colors.length,
      itemBuilder: (context, index) {
        final Color color = colors[index];
        return RadioListTile(
          title: Card(color: color, child: SizedBox(width: 100, height: 40)),
          value: index,
          groupValue: seleccionado,
          activeColor: color,
          onChanged: (value) {
            ref.read(themeProvider.notifier).changeColor(index);
          },
        );
      },
    );
  }
}
