part of 'order_contents_bloc.dart';

@immutable
class OrderContentsState extends Equatable {
  final Map<int, Pizza> products;
  final int selected;
  final int totalPrice;
  final Order? order;
  final bool saved;

  @override
  String toString() => 'Producto seleccionado: $selected, pizzas: $products';

  const OrderContentsState({
    this.products = const {},
    this.selected = 0,
    this.totalPrice = 0,
    this.order,
    this.saved = false,
  });

  @override
  List<Object?> get props => [saved, products, selected, totalPrice, order];

  OrderContentsState copyWith({
    final Map<int, Pizza>? products,
    final int? selected,
    final int? totalPrice,
    final Order? order,
    final bool? saved,
  }) => OrderContentsState(
    selected: selected ?? this.selected,
    products: products ?? this.products,
    totalPrice: totalPrice ?? this.totalPrice,
    order: order ?? this.order,
    saved: saved ?? this.saved,
  );
}

class OrderContentsInitial extends OrderContentsState {
  const OrderContentsInitial({super.order, super.saved})
    : super(products: const {}, selected: 0, totalPrice: 0);
}

class OrderContentsLoading extends OrderContentsState {
  const OrderContentsLoading({
    super.products,
    required super.selected,
    super.totalPrice,
    super.order,
    super.saved,
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
  });
  @override
  List<Object?> get props => [
    saved,
    products,
    selected,
    totalPrice,
    order,
    errorMessage,
  ];
}

class OrderContentsActive extends OrderContentsState {
  const OrderContentsActive({
    required super.products,
    super.selected,
    super.totalPrice,
    super.order,
    super.saved,
  });
}
