import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/domain/repositories/order_repository.dart';
import 'package:dice_pizza/infraestructure/datasources/order_isar_datasource.dart';
import 'package:dice_pizza/infraestructure/repositories/local_order_repository.dart';
import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_database_event.dart';
part 'order_database_state.dart';

class OrderDatabaseBloc extends Bloc<OrderDatabaseEvent, OrderDatabaseState> {
  late final OrderRepository repository;
  final int userId;
  final String username;
  OrderDatabaseBloc({this.userId = 0, this.username = 'Anonymous'})
    : super(OrderDatabaseInitial()) {
    final datasource = OrderIsarDatasource();
    datasource.init();
    repository = LocalOrderRepository(datasource);

    on<SaveOrder>((event, emit) => _onSaveOrder(event, emit));
    on<DeleteOrder>((event, emit) => _onDeleteOrder(event, emit));
    on<ReadOrder>((event, emit) => _onReadOrder(event, emit));
    on<UpdateOrder>((event, emit) => _onUpdateOrder(event, emit));
    on<ReadAllOrders>((event, emit) => _onReadAllOrders(event, emit));
    on<ReadAllOrdersByUser>((event, emit) => _onReadOrdersByUser(event, emit));
    on<ResetSearch>((event, emit) => _reset(emit));
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
      final contents = event.context.read<OrderContentsBloc>().state;
      if (contents.products == {} ||
          contents.products.isEmpty ||
          contents is OrderContentsInitial) {
        emit(
          OrderDatabaseError(message: 'No se puede guardar un pedido vacío'),
        );
        return;
      }
      Order? order =
          contents.order ??
          Order(
            createdBy: userId,
            creatorName: username,
            products: contents.products.values.toList(),
            id: contents.order?.id,
          );
      await repository.createOrder(order).then((id) {
        emit(OrderDatabaseSaved(id!));
        if (event.context.mounted) {
          event.context.read<OrderContentsBloc>().add(
            OrderContentsSaved(order.copyWith(id: id)),
          );
        }
      });
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
      await repository.getOrderById(event.orderId).then((order) {
        emit(OrderDatabaseGet(order!));
      });
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
    if (_loading() || _resultsEmpty()) {
      return;
    } else {
      _setLoading(emit);
    }
    try {
      await repository.getAllOrders(page: event.page).then((list) {
        if (list.isEmpty) {
          emit(OrderDatabaseRanOut());
        } else {
          emit(OrderDatabaseGetMany(list));
        }
      });
    } catch (e) {
      emit(OrderDatabaseError(message: 'Error al recuperar pedidos'));
    }
  }

  Future<void> _onReadOrdersByUser(
    ReadAllOrdersByUser event,
    Emitter<OrderDatabaseState> emit,
  ) async {
    if (_loading() || _resultsEmpty()) {
      return;
    } else {
      _setLoading(emit);
    }
    try {
      await repository.getOrderByCreator(event.creator).then((list) {
        if (list.isEmpty) {
          emit(OrderDatabaseRanOut());
        } else {
          emit(OrderDatabaseGetMany(list));
        }
      });
    } catch (e) {
      emit(
        OrderDatabaseError(
          message:
              'Error al recuperar pedidos creados por usuario ${event.creator}',
        ),
      );
    }
  }

  void _reset(Emitter<OrderDatabaseState> emit) {
    emit(OrderDatabaseInitial());
  }

  bool _loading() {
    return state is OrderDatabaseLoading;
  }

  bool _resultsEmpty() {
    return state is OrderDatabaseRanOut;
  }

  void _setLoading(Emitter<OrderDatabaseState> emit) async {
    emit(OrderDatabaseLoading());
    await Future.delayed(Duration(milliseconds: 200));
  }
}
