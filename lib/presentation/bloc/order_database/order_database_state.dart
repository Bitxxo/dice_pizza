part of 'order_database_bloc.dart';

abstract class OrderDatabaseState extends Equatable {
  const OrderDatabaseState();

  @override
  List<Object> get props => [];
}

class OrderDatabaseInitial extends OrderDatabaseState {
  const OrderDatabaseInitial();
}

class OrderDatabaseSaved extends OrderDatabaseState {
  final int savedId;
  const OrderDatabaseSaved(this.savedId);
  @override
  List<Object> get props => [savedId];
}

class OrderDatabaseGet extends OrderDatabaseState {
  final Order order;
  const OrderDatabaseGet(this.order);
  @override
  List<Object> get props => [order];
}

class OrderDatabaseGetMany extends OrderDatabaseState {
  final List<Order> orderList;
  const OrderDatabaseGetMany(this.orderList);
  @override
  List<Object> get props => [orderList];
}

class OrderDatabaseLoading extends OrderDatabaseState {
  const OrderDatabaseLoading();
}

class OrderDatabaseError extends OrderDatabaseState {
  final String message;
  const OrderDatabaseError({this.message = 'Error desconocido'});
  @override
  List<Object> get props => [message];
}

class OrderDatabaseRanOut extends OrderDatabaseState {}
