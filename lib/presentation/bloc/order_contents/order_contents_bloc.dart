import 'package:dice_pizza/domain/entities/ingredient.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_contents_event.dart';
part 'order_contents_state.dart';

class OrderContentsBloc extends Bloc<OrderContentsEvent, OrderContentsState> {
  OrderContentsBloc() : super(OrderContentsInitial()) {
    on<OrderContentsRead>((event, emit) => _readOrder(event, emit));
    on<PizzaSelected>((event, emit) => _onPizzaSelected(event, emit));
    on<PizzaAdded>((event, emit) => _onPizzaAdded(event, emit));
    on<PizzaRemoved>((event, emit) => _onPizzaRemoved(event, emit));
    on<PizzaEdited>((event, emit) => _onPizzaEdited(event, emit));
    on<IngredientToggled>((event, emit) => _onIngredientToggled(event, emit));
    on<OrderContentsSaved>((event, emit) => _saveOrder(event, emit));
    on<TogglePaid>((event, emit) => _togglePaid(event, emit));
    on<OrderContentsEvent>((event, emit) {});
  }

  //Guarda la pizza seleccionada en el estado
  void _onPizzaSelected(PizzaSelected event, emit) {
    emit(state.copyWith(selected: event.index));
  }

  ///Añade una pizza al pedido
  void _onPizzaAdded(PizzaAdded event, emit) {
    if (_loading()) {
      return;
    } else if (state is OrderContentsInitial) {
      _setLoading(emit);
      emit(
        OrderContentsActive(
          products: {0: event.pizza},
          totalPrice: event.pizza.price,
          paid: false,
        ),
      );
    } else {
      _setLoading(emit);
      final id = state.products.length;
      Map<int, Pizza> editedOrder = state.products;
      editedOrder.addAll({id: event.pizza});
      emit(
        OrderContentsActive(
          products: editedOrder,
          selected: id,
          totalPrice: _getTotalPrice(),
          order: state.order,
          saved: false,
          paid: state.paid,
        ),
      );
    }
  }

  ///Elimina una pizza del pedido
  void _onPizzaRemoved(PizzaRemoved event, emit) {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    int id = event.index == -1 ? state.selected : event.index;
    Map<int, Pizza> editedOrder = state.products;
    editedOrder.removeWhere((index, product) => index == id);
    editedOrder = _rearrange(editedOrder);
    if (id - 1 >= 0) id--;
    emit(
      OrderContentsActive(
        products: editedOrder,
        selected: id,
        totalPrice: _getTotalPrice(),
        order: state.order,
        saved: false,
        paid: state.paid,
      ),
    );
  }

  ///Modifica una pizza ya presente en el pedido
  void _onPizzaEdited(PizzaEdited event, emit) {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    final int id = state.selected;
    Map<int, Pizza> editedOrder = state.products;
    editedOrder[id] = event.pizza;
    emit(
      OrderContentsActive(
        products: editedOrder,
        selected: id,
        totalPrice: _getTotalPrice(),
        order: state.order,
        saved: false,
        paid: state.paid,
      ),
    );
  }

  //Elimina un ingrediente a una pizza del pedido
  void _onIngredientToggled(IngredientToggled event, emit) {
    if (_loading()) {
      return;
    } else if (state.products.isEmpty) {
      emit(
        OrderContentsError(
          paid: state.paid,
          products: state.products,
          selected: state.selected,
          errorMessage:
              'No hay productos sobre los que efectuar esta operación',
        ),
      );
      return;
    } else {
      _setLoading(emit);
    }
    final int id = state.selected;
    Map<int, Pizza> editedOrder = state.products;
    Pizza? editedPizza = editedOrder[id] ??= Pizza();
    if (editedPizza.ingredients!.contains(event.ingredient)) {
      editedPizza.removeIngredient(event.ingredient);
    } else if (!editedPizza.ingredients!.contains(event.ingredient)) {
      editedPizza.addIngredient(event.ingredient);
    }
    editedOrder[id] = editedPizza;
    emit(
      OrderContentsActive(
        products: editedOrder,
        selected: id,
        totalPrice: _getTotalPrice(),
        order: state.order,
        saved: false,
        paid: state.paid,
      ),
    );
  }

  Future<void> _saveOrder(OrderContentsSaved event, emit) async {
    if (_loading()) {
      return;
    }
    _setLoading(emit);
    if (event.order.id == null) {
      emit(
        OrderContentsError(
          products: state.products,
          selected: state.selected,
          errorMessage: 'Error al almacenar pedido',
          paid: state.paid,
          totalPrice: _getTotalPrice(),
        ),
      );
      return;
    }
    emit(
      OrderContentsActive(
        products: state.products,
        order: event.order,
        selected: state.selected,
        saved: true,
        paid: state.paid,
        totalPrice: _getTotalPrice(),
      ),
    );
  }

  //carga un pedido ya creado
  Future<void> _readOrder(OrderContentsRead event, emit) async {
    if (_loading()) return;
    _setLoading(emit);
    final loaded = OrderContentsActive(
      products: _loadProducts(event.order.products),
      order: event.order,
      saved: true,
      selected: state.selected,
      totalPrice: event.order.cost,
      paid: event.order.paid,
    );
    emit(loaded);
  }

  Future<void> _togglePaid(TogglePaid event, emit) async {
    if (_loading()) {
      return;
    } else if (state.products.isEmpty || state is OrderContentsInitial) {
      emit(
        OrderContentsError(
          products: state.products,
          selected: state.selected,
          errorMessage: '¡No hay productos que pagar!',
          order: state.order,
        ),
      );
      return;
    }
    _setLoading(emit);
    final toggled = !(state.paid);
    emit(
      OrderContentsActive(
        products: state.products,
        order: state.order?.copyWith(paid: toggled),
        selected: state.selected,
        saved: false,
        totalPrice: _getTotalPrice(),
        paid: toggled,
      ),
    );
  }

  //Calcula el precio total del pedido
  int _getTotalPrice() {
    if (state.products.isEmpty) return 0;
    int total = 0;
    for (Pizza pizza in state.products.values) {
      total += pizza.price;
    }
    return total;
  }

  Map<int, Pizza> _loadProducts(List<Pizza> list) {
    int i = 0;
    Map<int, Pizza> products = {};
    for (Pizza p in list) {
      products.addAll({i: p});
      i++;
    }
    return products;
  }

  ///Reordena el map que representa el pedido
  Map<int, Pizza> _rearrange(Map<int, Pizza> currentOrder) {
    Map<int, Pizza> newMap = {};
    for (Pizza pizza in currentOrder.values) {
      newMap.addAll({newMap.length: pizza});
    }
    return newMap;
  }

  ///Emite el estado de carga
  void _setLoading(Emitter<OrderContentsState> emit) {
    emit(
      OrderContentsLoading(
        products: state.products,
        selected: state.selected,
        totalPrice: state.totalPrice,
        order: state.order,
        paid: state.paid,
      ),
    );
  }

  bool _loading() {
    return state is OrderContentsLoading;
  }
}
