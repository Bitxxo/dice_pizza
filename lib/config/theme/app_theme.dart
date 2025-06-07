import 'package:flutter/material.dart';

const listaColores = <Color>[
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
  final bool modoOscuro;
  AppTheme({this.selected = 0, this.modoOscuro = false})
    : assert(selected >= 0, 'El color debe ser mayor que 0'),
      assert(selected < listaColores.length, 'El color debe ser menor de 10');

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: listaColores[selected],
    brightness: modoOscuro ? Brightness.dark : Brightness.light,
    appBarTheme: const AppBarTheme(centerTitle: false),
  );
  //método típico para copiar una instancia de la clase
  AppTheme copyWith({int? seleccionado, bool? modoOscuro}) => AppTheme(
    selected: seleccionado ?? this.selected,
    modoOscuro: modoOscuro ?? this.modoOscuro,
  );
}
