part of 'order_contents_bloc.dart';

@immutable
class OrderContentsState extends Equatable {
  final Map<int, Pizza> products;
  final int selected;
  final int totalPrice;
  final Order? order;
  final bool saved;
  final bool paid;

  @override
  String toString() => 'Producto seleccionado: $selected, pizzas: $products';

  const OrderContentsState({
    this.products = const {},
    this.selected = 0,
    this.totalPrice = 0,
    this.order,
    this.saved = false,
    this.paid = false,
  });

  @override
  List<Object?> get props => [
    saved,
    products,
    selected,
    totalPrice,
    order,
    paid,
  ];

  OrderContentsState copyWith({
    final Map<int, Pizza>? products,
    final int? selected,
    final int? totalPrice,
    final Order? order,
    final bool? saved,
    final bool? paid,
  }) => OrderContentsState(
    selected: selected ?? this.selected,
    products: products ?? this.products,
    totalPrice: totalPrice ?? this.totalPrice,
    order: order ?? this.order,
    saved: saved ?? this.saved,
    paid: paid ?? this.paid,
  );
}

class OrderContentsInitial extends OrderContentsState {
  OrderContentsInitial({super.order, super.saved, super.paid})
    : super(products: {}, selected: 0, totalPrice: 0);
}

class OrderContentsLoading extends OrderContentsState {
  const OrderContentsLoading({
    super.products,
    required super.selected,
    super.totalPrice,
    super.order,
    super.saved,
    super.paid,
  });
}

class OrderContentsError extends OrderContentsState {
  final String errorMessage;

  const OrderContentsError({
    this.errorMessage = 'Unknown Error',
    required super.products,
    required super.selected,
    super.totalPrice,
    super.order,
    super.saved,
    super.paid,
  });
  @override
  List<Object?> get props => [
    saved,
    products,
    selected,
    totalPrice,
    order,
    errorMessage,
    paid,
  ];
}

class OrderContentsActive extends OrderContentsState {
  const OrderContentsActive({
    required super.products,
    super.selected,
    super.totalPrice,
    super.order,
    super.saved,
    super.paid,
  });
}
