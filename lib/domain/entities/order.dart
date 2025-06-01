import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:isar/isar.dart';

part 'order.g.dart';

@collection
class Order {
  Id? id;

  int createdBy;
  String creatorName;

  List<Pizza> products;
  int cost = 0;
  DateTime? lastModified;
  bool paid;

  Order({
    this.id,
    this.createdBy = -1,
    this.products = const [],
    this.cost = 0,
    this.lastModified,
    this.paid = false,
    this.creatorName = 'Anónimo',
  }) {
    if (products.isNotEmpty && cost == 0) {
      for (Pizza p in products) {
        cost += p.price;
      }
    }
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
