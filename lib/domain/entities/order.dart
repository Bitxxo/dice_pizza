import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:isar/isar.dart';

part 'order.g.dart';

@collection
class Order {
  Id? id;

  int createdBy;

  List<Pizza> products;
  int? cost;
  DateTime? lastModified;

  Order({
    this.id,
    this.createdBy = -1,
    this.products = const [],
    this.cost,
    this.lastModified,
  }) {
    lastModified = DateTime.now();
  }

  Order copyWith({
    Id? id = Isar.autoIncrement,
    int? createdBy,
    List<Pizza> products = const [],
    int? cost,
  }) {
    return Order(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      products: products.isEmpty ? this.products : products,
      cost: cost ?? this.cost,
      lastModified: DateTime.now(),
    );
  }
}
