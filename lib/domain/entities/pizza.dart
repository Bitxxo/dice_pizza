import 'package:dice_pizza/domain/entities/ingredient.dart';

class Pizza {
  Set<Ingredient> ingredients;
  Pizza({this.ingredients = const {}});

  void addIngredient(Ingredient ingredient) {
    ingredients.add(ingredient);
  }

  void removeIngredient(Ingredient ingredient) {
    ingredients.remove(ingredient);
  }
}

enum PizzaTypes { margarita, barbacoa, vegetal, hawaiana }
