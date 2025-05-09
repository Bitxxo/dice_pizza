import 'package:bloc/bloc.dart';
import 'package:dice_pizza/domain/entities/ingredient.dart';
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
    on<IngredientToggled>((event, emit) => _onIngredientToggled(event, emit));
  }

  ///Añade una pizza al pedido
  void _onPizzaAdded(event, emit) {
    if (state is OrderContentsInitial) {
      setLoading(emit);
      emit(OrderContentsState(order: {1: event.pizza}));
    } else {
      setLoading(emit);
      Map<int, Pizza> editedOrder = state.order;
      editedOrder[editedOrder.length + 1] = event.pizza;
      emit(OrderContentsState(order: editedOrder));
    }
  }

  ///Elimina una pizza del pedido
  void _onPizzaRemoved(event, emit) {
    setLoading(emit);
    Map<int, Pizza> editedOrder = state.order;
    editedOrder.removeWhere((index, product) => index == event.id);
    editedOrder = rearrange(editedOrder);
    emit(OrderContentsState(order: editedOrder));
  }

  ///Modifica una pizza ya presente en el pedido
  void _onPizzaEdited(event, emit) {
    setLoading(emit);
    Map<int, Pizza> editedOrder = state.order;
    editedOrder[event.id] = event.pizza;
    emit(OrderContentsState(order: editedOrder));
  }

  //Elimina un ingrediente a una pizza del pedido
  void _onIngredientToggled(event, emit) {
    setLoading(emit);
    Map<int, Pizza> editedOrder = state.order;
    Pizza? editedPizza = editedOrder[event.id];
    if (editedPizza == null) {
      emit(
        OrderContentsError(order: state.order, errorMessage: 'Pizza not found'),
      );
      return;
    } else if (editedPizza.ingredients.contains(event.ingredient)) {
      editedPizza.removeIngredient(event.ingredient);
    } else if (!editedPizza.ingredients.contains(event.ingredient)) {
      editedPizza.addIngredient(event.ingredient);
    }
    editedOrder[event.id] = editedPizza;
    emit(OrderContentsState(order: editedOrder));
  }

  ///Reordena el map que representa el pedido
  Map<int, Pizza> rearrange(Map<int, Pizza> currentOrder) {
    Map<int, Pizza> newMap = {};
    for (Pizza pizza in currentOrder.values) {
      newMap.addAll({newMap.length: pizza});
    }
    return newMap;
  }

  void setLoading(emit) {
    emit(OrderContentsLoading(order: state.order));
  }
}
