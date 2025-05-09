enum Ingredient { mozzarella, bacon, atun, cebolla, pina }

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
