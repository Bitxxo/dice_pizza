part of 'order_contents_bloc.dart';

@immutable
sealed class OrderContentsEvent {
  const OrderContentsEvent();
}

final class PizzaAdded extends OrderContentsEvent {
  final Pizza pizza;
  const PizzaAdded(this.pizza);
}

final class PizzaRemoved extends OrderContentsEvent {
  final int id;
  const PizzaRemoved(this.id);
}

final class PizzaEdited extends OrderContentsEvent {
  final int id;
  final Pizza pizza;
  const PizzaEdited(this.pizza, this.id);
}

final class IngredientToggled extends OrderContentsEvent {
  final Ingredient ingredient;
  final int id;
  const IngredientToggled(this.ingredient, this.id);
}
