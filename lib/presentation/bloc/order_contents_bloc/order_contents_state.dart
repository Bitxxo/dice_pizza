part of 'order_contents_bloc.dart';

@immutable
class OrderContentsState extends Equatable {
  final Map<int, Pizza> order;
  final int selected;

  const OrderContentsState({required this.order, this.selected = -1});

  @override
  List<Object?> get props => [order];

  OrderContentsState copyWith({
    final Map<int, Pizza>? order,
    final int? selected,
  }) => OrderContentsState(
    order: order ?? this.order,
    selected: selected ?? this.selected,
  );
}

class OrderContentsInitial extends OrderContentsState {
  const OrderContentsInitial() : super(order: const {});
}

class OrderContentsLoading extends OrderContentsState {
  const OrderContentsLoading({required super.order});
}

class OrderContentsError extends OrderContentsState {
  final String errorMessage;

  const OrderContentsError({
    this.errorMessage = 'Unknown Error',
    required super.order,
  });
}
