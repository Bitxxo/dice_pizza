part of 'order_database_bloc.dart';

abstract class OrderDatabaseEvent extends Equatable {
  const OrderDatabaseEvent();

  @override
  List<Object> get props => [];
}

class SaveOrder extends OrderDatabaseEvent {
  final Order order;
  const SaveOrder(this.order);
}

class UpdateOrder extends OrderDatabaseEvent {
  final Order order;
  final int orderId;
  const UpdateOrder({required this.order, required this.orderId});
}

class DeleteOrder extends OrderDatabaseEvent {
  final int orderId;
  const DeleteOrder(this.orderId);
}

class ReadOrder extends OrderDatabaseEvent {
  final int orderId;
  const ReadOrder(this.orderId);
}

class ReadAllOrders extends OrderDatabaseEvent {
  final int page;
  const ReadAllOrders({this.page = 0});
}

class ReadAllOrdersByUser extends OrderDatabaseEvent {
  final int creator;
  const ReadAllOrdersByUser(this.creator);
}
