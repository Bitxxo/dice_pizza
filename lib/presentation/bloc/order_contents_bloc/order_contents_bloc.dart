import 'package:bloc/bloc.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'order_contents_event.dart';
part 'order_contents_state.dart';

class OrderContentsBloc extends Bloc<OrderContentsEvent, OrderContentsState> {
  OrderContentsBloc() : super(OrderContentsInitial()) {
    on<OrderContentsEvent>((event, emit) {});

    on<PizzaAdded>((event, emit) => _onPizzaAdded(event, emit));
    on<PizzaRemoved>((event, emit) => _onPizzaRemoved(event, emit));
    on<PizzaEdited>((event, emit) => _onPizzaEdited(event, emit));
  }

  void _onPizzaAdded(event, emit) {}
  void _onPizzaRemoved(event, emit) {}
  void _onPizzaEdited(event, emit) {}
}
