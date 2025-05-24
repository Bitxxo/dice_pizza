part of 'order_database_bloc.dart';

abstract class OrderdatabaseEvent extends Equatable {
  const OrderdatabaseEvent();

  @override
  List<Object> get props => [];
}

class SaveOrder extends OrderdatabaseEvent {
  final Order order;
  const SaveOrder(this.order);
}

class UpdateOrder extends OrderdatabaseEvent {
  final Order order;
  final int orderId;
  const UpdateOrder({required this.order, required this.orderId});
}

class DeleteOrder extends OrderdatabaseEvent {
  final int orderId;
  const DeleteOrder(this.orderId);
}

class ReadOrder extends OrderdatabaseEvent {
  final int orderId;
  const ReadOrder(this.orderId);
}

class GetAllOrders extends OrderdatabaseEvent {
  final int page;
  const GetAllOrders({this.page = 0});
}

class GetAllOrdersByUser extends OrderdatabaseEvent {
  final int creator;
  const GetAllOrdersByUser(this.creator);
}
