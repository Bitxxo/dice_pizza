import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/bloc/order_database/order_database_bloc.dart';
import 'package:dice_pizza/presentation/widgets/order_list_tile.dart';
import 'package:dice_pizza/presentation/widgets/shared/loading_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          height: size.height * 0.5,
          child: _OrderListView(),
        ),
      ),
    );
  }
}

class _OrderListView extends StatefulWidget {
  const _OrderListView();

  @override
  State<_OrderListView> createState() => _OrderListViewState();
}

class _OrderListViewState extends State<_OrderListView> {
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
    return ListView.builder(
      itemCount: orders.length + 1,
      controller: controller,
      shrinkWrap: false,
      itemBuilder: (context, index) {
        if (index == orders.length && state is OrderDatabaseLoading ||
            orders.isEmpty) {
          return LoadingBox();
        }
        if (index == orders.length) return SizedBox(height: 100);

        final background = index % 2 == 0 ? colors.primary : colors.secondary;
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
