import 'package:json_annotation/json_annotation.dart';

enum Ingredient {
  @JsonValue('queso')
  queso,
  @JsonValue('bacon')
  bacon,
  @JsonValue('atun')
  atun,
  @JsonValue('cebolla')
  cebolla,
  @JsonValue('pina')
  pina,
  @JsonValue('pimiento')
  pimiento,
  @JsonValue('jamon')
  jamon,
  @JsonValue('champinon')
  champinon,
  @JsonValue('pollo')
  pollo,
  @JsonValue('polloVegano')
  polloVegano,
  @JsonValue('olivas')
  olivas,
}

//porque los enum no permiten ciertos caracteres
extension NameCorrections on Ingredient {
  String get value => switch (name) {
    'pina' => 'Piña',
    'atun' => 'Atún',
    'polloVegano' => 'Pollo vegano',
    'jamon' => 'Jamón',
    'champinon' => 'Champiñón',
    'queso' => 'Queso extra',
    _ => name.replaceFirst(
      name.substring(0, 1),
      name.substring(0, 1).toUpperCase(),
    ),
  };
}
