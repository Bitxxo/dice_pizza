import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/domain/entities/pizza.dart';

class OrderMapper {
  static Order fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    createdBy: json["created by"],
    products: List<Pizza>.from(
      json["products"].map((x) => {Pizza.fromJson(x)}),
    ),
    cost: json["cost"],
    lastModified: json["lastModified"],
  );

  static Map<String, dynamic> toJson(Order order) => {
    "id": order.id,
    "created by": order.createdBy,
    "products": List<Pizza>.from(
      order.products.map((Pizza pizza) => pizza.toJson()),
    ),
    "cost": order.cost,
    "lastModified": order.lastModified,
  };
}
