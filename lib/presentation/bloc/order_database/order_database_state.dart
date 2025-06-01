part of 'order_database_bloc.dart';

abstract class OrderDatabaseState extends Equatable {
  final int? id;
  const OrderDatabaseState(this.id);

  @override
  List<Object> get props => [];
}

class OrderDatabaseInitial extends OrderDatabaseState {
  const OrderDatabaseInitial(super.id);
}

class OrderDatabaseGet extends OrderDatabaseState {
  final Order order;
  const OrderDatabaseGet(this.order, super.id);
}

class OrderDatabaseGetMany extends OrderDatabaseState {
  final List<Order> order;
  const OrderDatabaseGetMany(this.order, super.id);
}

class OrderDatabaseLoading extends OrderDatabaseState {
  const OrderDatabaseLoading(super.id);
}

class OrderDatabaseError extends OrderDatabaseState {
  final String message;
  const OrderDatabaseError(super.id, {this.message = 'Error desconocido'});
}
