import 'package:dice_pizza/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//listado inmutable de colores
final colorsProvider = Provider((ref) => colors);

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>(
  (ref) => ThemeNotifier(),
);

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode() {
    state = state.copyWith(darkMode: !state.darkMode);
  }

  void changeColor(int seleccionado) {
    state = state.copyWith(selected: seleccionado);
  }
}
