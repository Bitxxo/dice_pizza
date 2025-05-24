part of 'order_database_bloc.dart';

abstract class OrderdatabaseState extends Equatable {
  const OrderdatabaseState();

  @override
  List<Object> get props => [];
}

class OrderdatabaseInitial extends OrderdatabaseState {}

class OrderdatabaseLoading extends OrderdatabaseState {}

class OrderdatabaseError extends OrderdatabaseState {
  final String message;
  const OrderdatabaseError({this.message = 'Error desconocido'});
}
