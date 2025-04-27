part of 'order_contents_bloc.dart';

@immutable
class OrderContentsState extends Equatable {
  final Map<int, Pizza> order;

  const OrderContentsState({this.order = const {}});

  @override
  List<Object?> get props => [order];

  OrderContentsState copyWith(final Map<int, Pizza>? order) =>
      OrderContentsState(order: order ?? this.order);
}

class OrderContentsInitial extends OrderContentsState {}

class OrderContentsLoading extends OrderContentsState {}

class OrderContentsError extends OrderContentsState {
  final String errorMessage;

  const OrderContentsError({this.errorMessage = 'Unknown Error'});
}
