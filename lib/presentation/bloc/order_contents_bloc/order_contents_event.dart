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
/*

class SaveOrder extends OrderContentsEvent {
  final int userId;
  const SaveOrder(this.userId);
}

class UpdateOrder extends OrderContentsEvent {
  final Order order;
  final int orderId;
  final int userId;
  const UpdateOrder({
    required this.order,
    required this.orderId,
    required this.userId,
  });
}

class DeleteOrder extends OrderContentsEvent {
  final int orderId;
  const DeleteOrder(this.orderId);
}

class ReadOrder extends OrderContentsEvent {
  final int orderId;
  const ReadOrder(this.orderId);
}
*/