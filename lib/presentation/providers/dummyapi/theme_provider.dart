import 'package:dice_pizza/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final darkModeProvider = StateProvider((ref) => false);

//listado inmutable de colores
final colorsProvider = Provider((ref) => listaColores);

final colorSeleccionadoProvider = StateProvider((ref) => 0);

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(modoOscuro: !state.modoOscuro);
  }

  void changeColor(int seleccionado) {
    state = state.copyWith(seleccionado: seleccionado);
  }
}
