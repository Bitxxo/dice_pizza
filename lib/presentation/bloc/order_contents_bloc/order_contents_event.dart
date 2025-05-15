part of 'order_contents_bloc.dart';

@immutable
sealed class OrderContentsEvent {
  const OrderContentsEvent();
}

final class PizzaSelected extends OrderContentsEvent {
  final int index;
  const PizzaSelected(this.index);
}

final class PizzaAdded extends OrderContentsEvent {
  final Pizza pizza;
  const PizzaAdded(this.pizza);
}

final class PizzaRemoved extends OrderContentsEvent {
  const PizzaRemoved();
}

final class PizzaEdited extends OrderContentsEvent {
  final Pizza pizza;
  const PizzaEdited(this.pizza);
}

final class IngredientToggled extends OrderContentsEvent {
  final Ingredient ingredient;
  const IngredientToggled(this.ingredient);
}
