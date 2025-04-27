part of 'order_contents_bloc.dart';

@immutable
class OrderContentsState extends Equatable {
  final Map<int, Pizza> order;

  const OrderContentsState({required this.order});

  @override
  List<Object?> get props => [order];

  OrderContentsState copyWith(final Map<int, Pizza>? order) =>
      OrderContentsState(order: order ?? this.order);
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
