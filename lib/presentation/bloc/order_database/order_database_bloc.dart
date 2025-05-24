import 'package:bloc/bloc.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:equatable/equatable.dart';

part 'order_database_event.dart';
part 'order_database_state.dart';

class OrderdatabaseBloc extends Bloc<OrderdatabaseEvent, OrderdatabaseState> {
  OrderdatabaseBloc() : super(OrderdatabaseInitial());
}
