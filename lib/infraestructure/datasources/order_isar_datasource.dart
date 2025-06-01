import 'package:dice_pizza/domain/datasources/order_datasource.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

///Allows interaction with an Isar database
class OrderIsarDatasource extends OrderDatasource {
  late final Isar db;

  OrderIsarDatasource() {
    init();
  }
  //Initializes the database instance
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.getInstance() == null) {
      final isar = await Isar.open([OrderSchema], directory: dir.path);
      db = isar;
    } else {
      db = Isar.getInstance()!;
    }
  }

  ///Stores an order in the database
  @override
  Future<int?> createOrder(Order order) async {
    try {
      int? id;
      await db.writeTxn(() async {
        id = await db.orders.put(order);
      });
      return id;
    } catch (e) {
      return null;
    }
  }

  ///Modifies an order in the database
  @override
  Future<bool> updateOrder({required Order edited, required int id}) async {
    final Order? old = await db.orders.get(id);
    if (old == null) return false;
    try {
      edited.id = old.id;
      await db.writeTxn(() async {
        await db.orders.put(edited);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  ///Removes an order from the database
  @override
  Future<bool> deleteOrder(int id) async {
    return await db.orders.delete(id);
  }

  ///Retrieves all orders available in the database, in groups of 10
  @override
  Future<List<Order>> getAllOrders({int page = 0}) async {
    final query = db.orders.buildQuery(
      limit: (page + 1) * 10,
      offset: page * 10,
    );
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
    final results = db.orders.filter().createdByEqualTo(id).findAll();
    return results;
  }

  ///Retrieves a specific Order, for which the id is given, from the datasource
  @override
  Future<Order?> getOrderById(int id) async {
    return db.orders.filter().idEqualTo(id).findFirst();
  }
}
