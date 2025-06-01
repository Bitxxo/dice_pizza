part of 'order_contents_bloc.dart';

@immutable
class OrderContentsState extends Equatable {
  final Map<int, Pizza> products;
  final int selected;
  final int totalPrice;

  @override
  String toString() => 'Producto seleccionado: $selected, pizzas: $products';

  const OrderContentsState({
    this.products = const {},
    this.selected = 0,
    this.totalPrice = 0,
  });

  @override
  List<Object?> get props => [products, selected];

  OrderContentsState copyWith({
    final Map<int, Pizza>? products,
    final int? selected,
    final int? totalPrice,
  }) => OrderContentsState(
    selected: selected ?? this.selected,
    products: products ?? this.products,
    totalPrice: totalPrice ?? this.totalPrice,
  );
}

class OrderContentsInitial extends OrderContentsState {
  const OrderContentsInitial()
    : super(products: const {}, selected: 0, totalPrice: 0);
}

class OrderContentsLoading extends OrderContentsState {
  const OrderContentsLoading({
    super.products,
    required super.selected,
    super.totalPrice,
  });
}

class OrderContentsError extends OrderContentsState {
  final String errorMessage;

  const OrderContentsError({
    this.errorMessage = 'Unknown Error',
    required super.products,
    required super.selected,
    super.totalPrice,
  });
}

class OrderContentsActive extends OrderContentsState {
  const OrderContentsActive({
    required super.products,
    super.selected,
    super.totalPrice,
  });
}
