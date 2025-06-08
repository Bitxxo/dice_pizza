import 'package:dice_pizza/domain/entities/pizza.dart';
import 'package:dice_pizza/domain/extensions/last_modified_format.dart';
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
    lastModified ??= DateTime.now();
  }

  Order copyWith({
    Id? id = Isar.autoIncrement,
    int? createdBy,
    List<Pizza>? products,
    int? cost,
    bool? paid,
  }) {
    return Order(
      id: id ?? this.id,
      createdBy: createdBy ?? this.createdBy,
      products: products ?? this.products,
      cost: cost ?? this.cost,
      lastModified: DateTime.now(),
      paid: paid ?? this.paid,
    );
  }

  @override
  String toString() {
    return 'Order $id, contents: $products';
  }

  String get lastModifiedDate => lastModified!.lastModifiedFormat();
  String get productNames {
    String names = '';
    for (Pizza p in products) {
      names += '[${p.name}] ';
    }
    return names;
  }

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    createdBy: json["created by"],
    products: List<Pizza>.from(json["products"].map((x) => Pizza.fromJson(x))),
    cost: json["cost"],
    paid: json["paid"],
    lastModified: json["lastModified"],
    creatorName: json["creatorNmae"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created by": createdBy,
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
    "cost": cost,
    "paid": paid,
    "lastModified": lastModified,
    "creatorNmae": creatorName,
  };
}
