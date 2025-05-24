import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:isar/isar.dart';

part 'pizza.g.dart';

@embedded
class Pizza {
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

  Pizza copyWith({List<Ingredient>? ingredients, int? price, int? orderId}) {
    return Pizza(
      ingredients: ingredients ?? this.ingredients,
      price: price ?? this.price,
    );
  }

  factory Pizza.fromJson(Map<String, dynamic> json) => Pizza(
    ingredients: List<Ingredient>.from(json["ingredients"].map((x) => x)),
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
    "price": price,
  };
}

enum PizzaTypes { margarita, barbacoa, vegetal, hawaiana }
