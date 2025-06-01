import 'package:bloc/bloc.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/domain/repositories/order_repository.dart';
import 'package:dice_pizza/infraestructure/datasources/order_isar_datasource.dart';
import 'package:dice_pizza/infraestructure/repositories/local_order_repository.dart';
import 'package:equatable/equatable.dart';

part 'order_database_event.dart';
part 'order_database_state.dart';

class OrderDatabaseBloc extends Bloc<OrderDatabaseEvent, OrderDatabaseState> {
  late final OrderRepository repository;
  OrderDatabaseBloc() : super(OrderDatabaseInitial()) {
    repository = LocalOrderRepository(OrderIsarDatasource());

    on<SaveOrder>((event, emit) => _onSaveOrder(event, emit));
    on<DeleteOrder>((event, emit) => _onDeleteOrder(event, emit));
    on<ReadOrder>((event, emit) => _onReadOrder(event, emit));
    on<UpdateOrder>((event, emit) => _onUpdateOrder(event, emit));
    on<ReadAllOrders>((event, emit) => _onReadAllOrders(event, emit));
    on<ReadAllOrdersByUser>((event, emit) => _onReadOrdersByUser(event, emit));

    on<OrderDatabaseEvent>((event, emit) {});
  }

  Future<void> _onSaveOrder(
    SaveOrder event,
    Emitter<OrderDatabaseState> emit,
  ) async {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    try {
      await repository.createOrder(event.order);
      emit(OrderDatabaseInitial());
    } catch (e) {
      emit(OrderDatabaseError(message: 'Error al guardar el pedido'));
    }
  }

  Future<void> _onDeleteOrder(
    DeleteOrder event,
    Emitter<OrderDatabaseState> emit,
  ) async {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    try {
      await repository.deleteOrder(event.orderId);
      emit(OrderDatabaseInitial());
    } catch (e) {
      emit(OrderDatabaseError(message: 'Error al eliminar el pedido'));
    }
  }

  Future<void> _onReadOrder(
    ReadOrder event,
    Emitter<OrderDatabaseState> emit,
  ) async {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    try {
      await repository.getOrderById(event.orderId);
      emit(OrderDatabaseInitial());
    } catch (e) {
      emit(OrderDatabaseError(message: 'Error al recuperar el pedido'));
    }
  }

  Future<void> _onUpdateOrder(
    UpdateOrder event,
    Emitter<OrderDatabaseState> emit,
  ) async {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    try {
      await repository.updateOrder(edited: event.order, id: event.orderId);
      emit(OrderDatabaseInitial());
    } catch (e) {
      emit(OrderDatabaseError(message: 'Error al modificar el pedido'));
    }
  }

  Future<void> _onReadAllOrders(
    ReadAllOrders event,
    Emitter<OrderDatabaseState> emit,
  ) async {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    try {
      await repository.getAllOrders(page: event.page);
      emit(OrderDatabaseInitial());
    } catch (e) {
      emit(OrderDatabaseError(message: 'Error al recuperar pedidos'));
    }
  }

  Future<void> _onReadOrdersByUser(
    ReadAllOrdersByUser event,
    Emitter<OrderDatabaseState> emit,
  ) async {
    if (_loading()) {
      return;
    } else {
      _setLoading(emit);
    }
    try {
      await repository.getOrderByCreator(event.creator);
      emit(OrderDatabaseInitial());
    } catch (e) {
      emit(
        OrderDatabaseError(
          message:
              'Error al recuperar pedidos creados por usuario ${event.creator}',
        ),
      );
    }
  }

  bool _loading() {
    return state is OrderDatabaseLoading;
  }

  void _setLoading(Emitter<OrderDatabaseState> emit) {
    emit(OrderDatabaseLoading());
  }
}
