class Ingredient {
  final bool isDouble;
  final IngredientName type;

  Ingredient(this.type, {this.isDouble = false});
}

enum IngredientName { mozzarella, bacon, atun, cebolla, pina }

//porque los enum no permiten ciertos caracteres
extension NameCorrections on IngredientName {
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
