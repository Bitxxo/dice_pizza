part of 'order_database_bloc.dart';

abstract class OrderDatabaseState extends Equatable {
  const OrderDatabaseState();

  @override
  List<Object> get props => [];
}

class OrderDatabaseInitial extends OrderDatabaseState {}

class OrderDatabaseLoading extends OrderDatabaseState {}

class OrderDatabaseError extends OrderDatabaseState {
  final String message;
  const OrderDatabaseError({this.message = 'Error desconocido'});
}
