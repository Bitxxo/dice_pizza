import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:isar/isar.dart';

part 'pizza.g.dart';

@collection
class Pizza {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  List<Ingredient> ingredients;

  int price;
  Pizza({this.ingredients = const [], this.price = 2});

  void addIngredient(Ingredient ingredient) {
    if (!ingredients.contains(ingredient)) {
      ingredients.add(ingredient);
    } else {
      return;
    }
  }

  void removeIngredient(Ingredient ingredient) {
    if (ingredients.contains(ingredient)) {
      ingredients.remove(ingredient);
    } else {
      return;
    }
  }

  Pizza copyWith({List<Ingredient>? ingredients, int? price}) {
    return Pizza(
      ingredients: ingredients ?? this.ingredients,
      price: price ?? this.price,
    );
  }
}

enum PizzaTypes { margarita, barbacoa, vegetal, hawaiana }
