import 'package:dice_pizza/presentation/widgets/order_database/order_database_listview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderDatabaseScreen extends StatelessWidget {
  const OrderDatabaseScreen({super.key});
  static const name = 'ViewOrders';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos almacenados'),
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back),
        ),
      ),
      backgroundColor: colors.primaryContainer,
      body: Center(
        child: SizedBox(
          width: size.width * 0.5,
          height: size.height * 0.7,
          child: OrderDatabaseListView(),
        ),
      ),
    );
  }
}
