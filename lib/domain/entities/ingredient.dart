class Ingredient {
  final bool isDouble;
  final IngredientName type;

  Ingredient(this.type, {this.isDouble = false});
}

enum IngredientName { mozzarella, bacon, atun, cebolla }
