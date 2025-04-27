import 'package:bloc/bloc.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'order_contents_event.dart';
part 'order_contents_state.dart';

class OrderContentsBloc extends Bloc<OrderContentsEvent, OrderContentsState> {
  OrderContentsBloc() : super(OrderContentsInitial()) {
    on<OrderContentsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
