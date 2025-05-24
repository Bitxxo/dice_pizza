part of 'order_contents_bloc.dart';

@immutable
class OrderContentsState extends Equatable {
  final Order order;
  final Map<int, Pizza> products;
  final int selected;

  const OrderContentsState({
    required this.order,
    this.products = const {},
    this.selected = -1,
  });

  @override
  List<Object?> get props => [order];

  OrderContentsState copyWith({final Order? order, final int? selected}) =>
      OrderContentsState(
        order: order ?? this.order,
        selected: selected ?? this.selected,
      );
}

class OrderContentsInitial extends OrderContentsState {
  OrderContentsInitial() : super(order: Order(), products: const {});
}

class OrderContentsLoading extends OrderContentsState {
  const OrderContentsLoading({required super.order, super.products});
}

class OrderContentsError extends OrderContentsState {
  final String errorMessage;

  const OrderContentsError({
    this.errorMessage = 'Unknown Error',
    required super.order,
    required super.products,
  });
}
