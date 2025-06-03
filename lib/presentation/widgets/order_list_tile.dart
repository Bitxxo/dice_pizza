import 'package:dice_pizza/domain/entities/order.dart';
import 'package:flutter/material.dart';

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
        child: InkWell(
          onTap: () {},
          hoverColor: background.withAlpha(100),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            tileColor: background,
            textColor: textColor,
            title: Text(
              'Pedido ${order.id}, creado por ${order.creatorName}, Modificado: ${order.lastModifiedDate}',
            ),
            subtitle: Text('${order.productNames}'),
          ),
        ),
      ),
    );
  }
}
