import 'package:bloc/bloc.dart';
import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'order_contents_event.dart';
part 'order_contents_state.dart';

class OrderContentsBloc extends Bloc<OrderContentsEvent, OrderContentsState> {
  OrderContentsBloc() : super(OrderContentsInitial()) {
    on<PizzaSelected>((event, emit) => _onPizzaSelected(event, emit));
    on<PizzaAdded>((event, emit) => _onPizzaAdded(event, emit));
    on<PizzaRemoved>((event, emit) => _onPizzaRemoved(event, emit));
    on<PizzaEdited>((event, emit) => _onPizzaEdited(event, emit));
    on<IngredientToggled>((event, emit) => _onIngredientToggled(event, emit));
    on<OrderContentsEvent>((event, emit) {});
  }

  //Guarda la pizza seleccionada en el estado
  void _onPizzaSelected(PizzaSelected event, emit) {
    emit(state.copyWith(selected: event.index));
  }

  ///Añade una pizza al pedido
  void _onPizzaAdded(PizzaAdded event, emit) {
    if (state is OrderContentsInitial) {
      _setLoading(emit);
      emit(OrderContentsActive(products: {0: event.pizza}));
    } else {
      if (_loading()) {
        return;
      } else {
        _setLoading(emit);
      }
      Map<int, Pizza> editedOrder = state.products;
      editedOrder[editedOrder.length] = event.pizza;
      emit(OrderContentsActive(products: editedOrder));
    }
  }

  ///Elimina una pizza del pedido
  void _onPizzaRemoved(PizzaRemoved event, emit) {
    final int id = state.selected;
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    Map<int, Pizza> editedOrder = state.products;
    editedOrder.removeWhere((index, product) => index == id);
    editedOrder = _rearrange(editedOrder);
    emit(OrderContentsActive(products: editedOrder));
  }

  ///Modifica una pizza ya presente en el pedido
  void _onPizzaEdited(PizzaEdited event, emit) {
    final int id = state.selected;
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    Map<int, Pizza> editedOrder = state.products;
    editedOrder[id] = event.pizza;
    emit(OrderContentsActive(products: editedOrder));
  }

  //Elimina un ingrediente a una pizza del pedido
  void _onIngredientToggled(IngredientToggled event, emit) {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    final int id = state.selected;
    Map<int, Pizza> editedOrder = state.products;
    Pizza? editedPizza = editedOrder[id];
    if (editedPizza == null) {
      emit(
        OrderContentsError(
          selected: state.selected,
          products: state.products,
          errorMessage: 'Pizza not found',
        ),
      );
      return;
    } else if (editedPizza.ingredients.contains(event.ingredient)) {
      editedPizza.removeIngredient(event.ingredient);
    } else if (!editedPizza.ingredients.contains(event.ingredient)) {
      editedPizza.addIngredient(event.ingredient);
    }
    editedOrder[id] = editedPizza;
    emit(OrderContentsActive(products: editedOrder));
  }

  ///Reordena el map que representa el pedido
  Map<int, Pizza> _rearrange(Map<int, Pizza> currentOrder) {
    Map<int, Pizza> newMap = {};
    for (Pizza pizza in currentOrder.values) {
      newMap.addAll({newMap.length: pizza});
    }
    return newMap;
  }

  void _setLoading(Emitter<OrderContentsState> emit) {
    emit(
      OrderContentsLoading(products: state.products, selected: state.selected),
    );
  }

  bool _loading() {
    return state is OrderContentsLoading;
  }
}
