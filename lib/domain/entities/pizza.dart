import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

part 'pizza.g.dart';

@embedded
class Pizza {
  @Enumerated(EnumType.name)
  List<Ingredient>? ingredients = [];
  String name = '';

  int price;
  Pizza({this.ingredients, this.price = 3, this.name = ''}) {
    ingredients ??= [];
    price = 3 + ingredients!.length * 2;
    name = getName();
    ingredients!.sort((a, b) => a.value.compareTo(b.value));
  }

  factory Pizza.fromJson(Map<String, dynamic> json) => Pizza(
    ingredients: List<Ingredient>.from(json["ingredients"].map((x) => x)),
    price: json["price"],
  );

  factory Pizza.fromType(PizzaTypes type) => switch (type.name) {
    'barbacoa' => Pizza(ingredients: [Ingredient.bacon, Ingredient.cebolla]),
    'vegetal' => Pizza(
      ingredients: [
        Ingredient.cebolla,
        Ingredient.champinon,
        Ingredient.pimiento,
      ],
    ),
    'hawaiana' => Pizza(ingredients: [Ingredient.jamon, Ingredient.pina]),
    'vegana' => Pizza(
      ingredients: [
        Ingredient.cebolla,
        Ingredient.champinon,
        Ingredient.pimiento,
        Ingredient.polloVegano,
      ],
    ),
    'carnaca' => Pizza(
      ingredients: [Ingredient.bacon, Ingredient.jamon, Ingredient.pollo],
    ),
    'carbonara' => Pizza(
      ingredients: [Ingredient.bacon, Ingredient.cebolla, Ingredient.champinon],
    ),
    'marinera' => Pizza(
      ingredients: [
        Ingredient.atun,
        Ingredient.cebolla,
        Ingredient.olivas,
        Ingredient.pimiento,
      ],
    ),
    'confusa' => Pizza(
      ingredients: [
        Ingredient.bacon,
        Ingredient.pina,
        Ingredient.polloVegano,
        Ingredient.queso,
      ],
    ),
    'margarita' || _ => Pizza(ingredients: []),
  };

  void addIngredient(Ingredient ingredient) {
    if (!ingredients!.contains(ingredient)) {
      ingredients!.add(ingredient);
      price += 2;
      ingredients!.sort((a, b) => a.value.compareTo(b.value));
      name = getName();
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

  String getName() {
    final name =
        pizzaTypeIngredients.entries
            .where((entry) => listEquals(entry.value, ingredients))
            .firstOrNull
            ?.key;
    return name ?? 'Personalizada';
  }

  String readableIngredients() {
    String result = '';
    if (ingredients == null || ingredients!.isEmpty) {
      return 'Solo tomate y queso';
    }
    for (Ingredient i in ingredients!) {
      result += i.value;
      if (i != ingredients!.lastOrNull) {
        result += ', ';
      }
    }
    return result;
  }

  void removeIngredient(Ingredient ingredient) {
    if (ingredients!.contains(ingredient)) {
      ingredients!.remove(ingredient);
      price -= 2;
      name = getName();
    } else {
      return;
    }
  }

  Map<String, dynamic> toJson() => {
    "ingredients": List<dynamic>.from(ingredients!.map((x) => x)),
    "price": price,
  };
}

enum PizzaTypes {
  margarita,
  barbacoa,
  vegetal,
  hawaiana,
  vegana,
  carnaca,
  carbonara,
  marinera,
  confusa,
}

const Map<String, List<Ingredient>> pizzaTypeIngredients = {
  'Margarita': [],
  'Barbacoa': [Ingredient.bacon, Ingredient.cebolla],
  'Vegetal': [Ingredient.cebolla, Ingredient.champinon, Ingredient.pimiento],
  'Hawaiana': [Ingredient.jamon, Ingredient.pina],
  'Vegana': [
    Ingredient.cebolla,
    Ingredient.champinon,
    Ingredient.pimiento,
    Ingredient.polloVegano,
  ],
  'Carnaca': [Ingredient.bacon, Ingredient.jamon, Ingredient.pollo],
  'Carbonara': [Ingredient.bacon, Ingredient.cebolla, Ingredient.champinon],
  'Marinera': [
    Ingredient.atun,
    Ingredient.cebolla,
    Ingredient.olivas,
    Ingredient.pimiento,
  ],
  'Confusa': [
    Ingredient.bacon,
    Ingredient.pina,
    Ingredient.polloVegano,
    Ingredient.queso,
  ],
};
