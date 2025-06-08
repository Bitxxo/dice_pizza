import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/presentation/bloc/order_database/order_database_bloc.dart';
import 'package:dice_pizza/presentation/widgets/order_database/order_list_tile.dart';
import 'package:dice_pizza/presentation/widgets/shared/error_message_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderDatabaseListView extends StatefulWidget {
  const OrderDatabaseListView({super.key});

  @override
  State<OrderDatabaseListView> createState() => _OrderDatabaseListViewState();
}

class _OrderDatabaseListViewState extends State<OrderDatabaseListView> {
  final ScrollController controller = ScrollController();
  int page = 0;
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    context.read<OrderDatabaseBloc>().stream.listen((state) {
      if (state is OrderDatabaseGetMany) {
        if (state.orderList.isNotEmpty) {
          setState(() {
            orders.addAll(state.orderList);
          });
        }
      }
    });
    _fetchOrders();
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 50) {
        _fetchOrders();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _fetchOrders() {
    if (context.read<OrderDatabaseBloc>().state is! OrderDatabaseRanOut) {
      context.read<OrderDatabaseBloc>().add(ReadAllOrders(page: page));
      setState(() {
        page++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final state = context.watch<OrderDatabaseBloc>().state;
<<<<<<< HEAD
    return (orders.isEmpty && state is! OrderDatabaseLoading)
=======
    return orders.isEmpty
>>>>>>> bc6a7a268518b024bb45dc430fe5fea5efee5493
        ? Center(
          child: ErrorMessageDisplay(
            message: 'No hay pedidos almacenados localmente',
          ),
        )
        : ListView.builder(
          itemCount: orders.length + 1,
          controller: controller,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            if (index == orders.length && state is OrderDatabaseLoading ||
                orders.isEmpty) {
              return SizedBox(width: 50, child: CircularProgressIndicator());
            }
            if (index == orders.length) return SizedBox(height: 100);

            final background =
                index % 2 == 0 ? colors.primary : colors.secondary;
            final textColor =
                index % 2 == 0 ? colors.onPrimary : colors.onSecondary;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OrderListTile(orders[index], background, textColor),
                Divider(),
              ],
            );
          },
        );
  }
}
