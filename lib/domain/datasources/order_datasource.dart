import 'package:dice_pizza/domain/entities/order.dart';

///Allows interaction with any datasource
abstract class OrderDatasource {
  ///Stores an order in the database
  Future<int?> createOrder(Order order);

  ///Modifies an order in the database
  Future<bool> updateOrder({required Order edited, required int id});

  ///Removes an order from the database
  Future<bool> deleteOrder(int id);

  ///Retrieves all orders available in the datasource
  Future<List<Order>> getAllOrders({int page});

  ///Retrieves a specific order, for which the creator's id is given, from the datasource
  Future<List<Order>> getOrderByCreator(int id);

  ///Retrieves a specific Order, for which the id is given, from the datasource
  Future<Order?> getOrderById(int id);
}
