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
  final int index;
  const PizzaRemoved(this.index);
}

final class PizzaEdited extends OrderContentsEvent {
  final Pizza pizza;
  const PizzaEdited(this.pizza);
}

final class IngredientToggled extends OrderContentsEvent {
  final Ingredient ingredient;
  const IngredientToggled(this.ingredient);
}

class SaveOrder extends OrderContentsEvent {
  final Order order;
  const SaveOrder(this.order);
}

class UpdateOrder extends OrderContentsEvent {
  final Order order;
  final int orderId;
  const UpdateOrder({required this.order, required this.orderId});
}

class DeleteOrder extends OrderContentsEvent {
  final int orderId;
  const DeleteOrder(this.orderId);
}

class ReadOrder extends OrderContentsEvent {
  final int orderId;
  const ReadOrder(this.orderId);
}
