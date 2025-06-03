import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderListTile extends StatelessWidget {
  final Order order;
  final Color background;
  final Color textColor;
  const OrderListTile(this.order, this.background, this.textColor, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      child: Material(
        child: ListTile(
          onTap: () {
            context.read<OrderContentsBloc>().add(OrderContentsRead(order));
            context.push(RouterPaths.dbProducts);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          tileColor: background,
          textColor: textColor,
          title: Text(
            'Pedido ${order.id}, creado por ${order.creatorName}, Modificado: ${order.lastModifiedDate}',
          ),
          subtitle: Text(order.productNames),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward, color: textColor),
            onPressed: () {
              context.read<OrderContentsBloc>().add(OrderContentsRead(order));
              context.push(RouterPaths.dbProducts);
            },
          ),
        ),
      ),
    );
  }
}
