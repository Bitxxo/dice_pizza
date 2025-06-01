import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/presentation/bloc/order_contents_bloc/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/bloc/order_database/order_database_bloc.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveOrderButton extends ConsumerWidget {
  final bool bigScreen;
  const SaveOrderButton(this.bigScreen, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider).value?.id ?? 0;
    return FilledButton.icon(
      onPressed: () {
        final products =
            context.read<OrderContentsBloc>().state.products.values.toList();
        final Order order = Order(createdBy: userId, products: products);
        context.read<OrderDatabaseBloc>().add(SaveOrder(order));
      },
      label: bigScreen ? Text('Guardar Pedido') : SizedBox.shrink(),
      icon: Icon(Icons.save, color: Colors.black),
    );
  }
}
