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
];

class AppTheme {
  final int seleccionado;

  AppTheme({this.seleccionado = 9})
    : assert(seleccionado >= 0, 'El color debe ser mayor que 0'),
      assert(
        seleccionado < listaColores.length,
        'El color debe ser menor de 10',
      );

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: listaColores[seleccionado],
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
