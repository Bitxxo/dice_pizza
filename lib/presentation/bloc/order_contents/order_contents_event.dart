part of 'order_contents_bloc.dart';

@immutable
sealed class OrderContentsEvent {
  const OrderContentsEvent();
}

class PizzaSelected extends OrderContentsEvent {
  final int index;
  const PizzaSelected(this.index);
}

class PizzaAdded extends OrderContentsEvent {
  final Pizza pizza;
  const PizzaAdded(this.pizza);
}

class PizzaRemoved extends OrderContentsEvent {
  final int index;
  const PizzaRemoved({this.index = -1});
}

class PizzaEdited extends OrderContentsEvent {
  final Pizza pizza;
  const PizzaEdited(this.pizza);
}

class IngredientToggled extends OrderContentsEvent {
  final Ingredient ingredient;
  const IngredientToggled(this.ingredient);
}

class OrderContentsSaved extends OrderContentsEvent {
  final Order order;
  const OrderContentsSaved(this.order);
}

class OrderContentsRead extends OrderContentsEvent {
  final Order order;
  const OrderContentsRead(this.order);
}

class TogglePaid extends OrderContentsEvent {}
