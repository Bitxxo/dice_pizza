import 'package:json_annotation/json_annotation.dart';

enum Ingredient {
  @JsonValue('mozzarella')
  mozzarella,
  @JsonValue('bacon')
  bacon,
  @JsonValue('atun')
  atun,
  @JsonValue('cebolla')
  cebolla,
  @JsonValue('pina')
  pina,
}

//porque los enum no permiten ciertos caracteres
extension NameCorrections on Ingredient {
  String get value {
    switch (name) {
      case 'pina':
        return 'piña';
      case 'atun':
        return 'atún';
      default:
        return name;
    }
  }
}
