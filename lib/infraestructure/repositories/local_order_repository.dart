import 'package:dice_pizza/domain/datasources/order_datasource.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/domain/repositories/order_repository.dart';

///Allows interaction with any datasource
class LocalOrderRepository extends OrderRepository {
  OrderDatasource source;
  LocalOrderRepository(this.source);

  ///Stores an order in the datasource
  @override
  Future<bool> createOrder(Order order) async {
    return await source.createOrder(order);
  }

  ///Modifies an order in the datasource
  @override
  Future<bool> updateOrder({required Order edited, required int id}) async {
    return await source.updateOrder(edited: edited, id: id);
  }

  ///Removes an order from the datasource
  @override
  Future<bool> deleteOrder(int id) async {
    return await source.deleteOrder(id);
  }

  ///Retrieves all orders available in the datasource
  @override
  Future<List<Order>> getAllOrders({int page = 0}) {
    return source.getAllOrders(page: page);
  }

  ///Retrieves a specific order, for which the creator's id is given, from the datasource
  @override
  Future<List<Order>> getOrderByCreator(int id) {
    return source.getOrderByCreator(id);
  }

  ///Retrieves a specific Order, for which the id is given, from the datasource
  @override
  Future<Order?> getOrderById(int id) async {
    return await source.getOrderById(id);
  }
}
