import 'package:dice_pizza/domain/datasources/order_datasource.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

///Allows interaction with an Isar database
class OrderIsarDatasource extends OrderDatasource {
  late Future<Isar> db;

  OrderIsarDatasource() {
    db = init();
  }
  //Initializes the database instance
  Future<Isar> init() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open([OrderSchema], directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  ///Stores an order in the database
  @override
  Future<int?> createOrder(Order order) async {
    final isar = await db;
    try {
      int? id;
      await isar.writeTxn(() async {
        id = await isar.orders.put(order);
      });
      return id;
    } catch (e) {
      return null;
    }
  }

  ///Modifies an order in the database
  @override
  Future<bool> updateOrder({required Order edited, required int id}) async {
    final isar = await db;
    final Order? old = await isar.orders.get(id);
    if (old == null) return false;
    try {
      edited.id = old.id;
      await isar.writeTxn(() async {
        await isar.orders.put(edited);
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  ///Removes an order from the database
  @override
  Future<bool> deleteOrder(int id) async {
    final isar = await db;
    return await isar.orders.delete(id);
  }

  ///Retrieves all orders available in the database, in groups of 10
  @override
  Future<List<Order>> getAllOrders({int page = 0}) async {
    final isar = await db;
    try {
      final query = isar.orders.buildQuery(
        limit: (page + 1) * 10,
        offset: page * 10,
        sortBy: [SortProperty(property: 'lastModified', sort: Sort.asc)],
      );
      final results = await query.findAll();
      return results.whereType<Order>().toList();
    } catch (e) {
      throw Exception('Unable to fetch orders from database');
    }
  }

  ///Retrieves a specific order, for which the creator's id is given, from the datasource
  @override
  Future<List<Order>> getOrderByCreator(int id) async {
    final isar = await db;
    final results = isar.orders.filter().createdByEqualTo(id).findAll();
    return results;
  }

  ///Retrieves a specific Order, for which the id is given, from the datasource
  @override
  Future<Order?> getOrderById(int id) async {
    final isar = await db;
    return isar.orders.filter().idEqualTo(id).findFirst();
  }
}
