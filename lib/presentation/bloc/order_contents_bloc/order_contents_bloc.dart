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
    on<OrderContentsEvent>((event, emit) {});
    on<PizzaSelected>((event, emit) => _onPizzaSelected(event, emit));
    on<PizzaAdded>((event, emit) => _onPizzaAdded(event, emit));
    on<PizzaRemoved>((event, emit) => _onPizzaRemoved(event, emit));
    on<PizzaEdited>((event, emit) => _onPizzaEdited(event, emit));
    on<IngredientToggled>((event, emit) => _onIngredientToggled(event, emit));
  }

  //Guarda la pizza seleccionada en el estado
  void _onPizzaSelected(event, emit) {
    emit(state.copyWith(selected: event.index));
  }

  ///Añade una pizza al pedido
  void _onPizzaAdded(event, emit) {
    if (state is OrderContentsInitial) {
      setLoading(emit);
      emit(
        OrderContentsState(
          products: {1: event.pizza},
          order: Order(products: [event.pizza]),
        ),
      );
    } else {
      setLoading(emit);
      Map<int, Pizza> editedOrder = state.products;
      editedOrder[editedOrder.length + 1] = event.pizza;
      emit(
        OrderContentsState(
          products: editedOrder,
          order: state.order.copyWith(products: editedOrder.values.toList()),
        ),
      );
    }
  }

  ///Elimina una pizza del pedido
  void _onPizzaRemoved(event, emit) {
    if (!selected(state)) return;
    final int id = state.selected;
    setLoading(emit);
    Map<int, Pizza> editedOrder = state.products;
    editedOrder.removeWhere((index, product) => index == id);
    editedOrder = rearrange(editedOrder);
    emit(
      OrderContentsState(
        products: editedOrder,
        order: state.order.copyWith(products: editedOrder.values.toList()),
      ),
    );
  }

  ///Modifica una pizza ya presente en el pedido
  void _onPizzaEdited(event, emit) {
    if (!selected(state)) return;
    final int id = state.selected;
    setLoading(emit);
    Map<int, Pizza> editedOrder = state.products;
    editedOrder[id] = event.pizza;
    emit(
      OrderContentsState(
        products: editedOrder,
        order: state.order.copyWith(products: editedOrder.values.toList()),
      ),
    );
  }

  //Elimina un ingrediente a una pizza del pedido
  void _onIngredientToggled(event, emit) {
    if (!selected(state)) return;
    final int id = state.selected;
    setLoading(emit);
    Map<int, Pizza> editedOrder = state.products;
    Pizza? editedPizza = editedOrder[id];
    if (editedPizza == null) {
      emit(
        OrderContentsError(
          products: state.products,
          order: state.order,
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
    emit(
      OrderContentsState(
        products: editedOrder,
        order: state.order.copyWith(products: editedOrder.values.toList()),
      ),
    );
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
    emit(OrderContentsLoading(order: state.order, products: state.products));
  }

  bool selected(OrderContentsState state) {
    return true;
  }
}
