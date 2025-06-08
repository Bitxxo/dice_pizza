import 'package:flutter/material.dart';

const colors = <Color>[
  Colors.cyan,
  Colors.orange,
  Colors.indigo,
  Colors.teal,
  Colors.red,
  Colors.lime,
  Colors.deepPurple,
  Colors.deepOrange,
  Colors.blueGrey,
  Colors.pinkAccent,
  Colors.green,
];

class AppTheme {
  final int selected;
  final bool darkMode;
  AppTheme({this.selected = 0, this.darkMode = false});

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: colors[selected],
    brightness: darkMode ? Brightness.dark : Brightness.light,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );

  AppTheme copyWith({int? selected, bool? darkMode}) => AppTheme(
    selected: selected ?? this.selected,
    darkMode: darkMode ?? this.darkMode,
  );
}
