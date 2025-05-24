import 'package:dice_pizza/domain/datasources/order_datasource.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

///Allows interaction with an Isar database
class OrderIsarDatasource extends OrderDatasource {
  late final IsarCollection<Order> db;

  OrderIsarDatasource() {
    init();
  }
  //Initializes the database instance
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open([OrderSchema], directory: dir.path);
    db = isar.orders;
  }

  ///Stores an order in the database
  @override
  Future<bool> createOrder(Order order) async {
    try {
      await db.put(order);
      return true;
    } catch (e) {
      return false;
    }
  }

  ///Modifies an order in the database
  @override
  Future<bool> updateOrder({required Order edited, required int id}) async {
    final Order? old = await db.get(id);
    if (old == null) return false;
    try {
      edited.id = old.id;
      await db.put(edited);
      return true;
    } catch (e) {
      return false;
    }
  }

  ///Removes an order from the database
  @override
  Future<bool> deleteOrder(int id) async {
    return await db.delete(id);
  }

  ///Retrieves all orders available in the database, in groups of 10
  @override
  Future<List<Order>> getAllOrders({int page = 0}) async {
    /*
    List<int> ids = [];
    for (int i = (page * 10) + 1; i < (page * 10) + 10; i++) {
      ids.add(i);
    }
    final results = await db.getAll(ids);
    */
    final query = db.buildQuery(limit: (page + 1) * 10, offset: page * 10);
    final results = await query.findAll();
    try {
      return results.whereType<Order>().toList();
    } catch (e) {
      throw Exception('Unable to fetch orders from database');
    }
  }

  ///Retrieves a specific order, for which the creator's id is given, from the datasource
  @override
  Future<List<Order>> getOrderByCreator(int id) async {
    final results = db.filter().createdByEqualTo(id).findAll();
    return results;
  }

  ///Retrieves a specific Order, for which the id is given, from the datasource
  @override
  Future<Order?> getOrderById(int id) async {
    return db.filter().idEqualTo(id).findFirst();
  }
}
