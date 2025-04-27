import 'package:dice_pizza/domain/entities/pizza.dart';

class Order {
  Map<int, Pizza> products;

  Order({this.products = const {}});

  void addPizza(Pizza pizza) {
    products.addAll({products.length: pizza});
  }

  void removePizza(int index) {
    products.remove(index);
    products = rearrange();
  }

  Map<int, Pizza> rearrange() {
    Map<int, Pizza> newMap = {};
    for (Pizza pizza in products.values) {
      newMap.addAll({newMap.length: pizza});
    }
    return newMap;
  }
}
