import 'package:dice_pizza/presentation/widgets/buttons/order_back_button.dart';
import 'package:dice_pizza/presentation/widgets/buttons/remove_product_button.dart';
import 'package:dice_pizza/presentation/widgets/buttons/save_order_button.dart';
import 'package:flutter/material.dart';

class OrderEditingScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  const OrderEditingScaffold({
    required this.child,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool bigScreen = MediaQuery.of(context).size.width > 600;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colors.tertiaryContainer,
        title: Text(title),
        toolbarHeight: 50,
        leading: OrderBackButton(),
        actions: [
          Row(children: [SaveOrderButton(bigScreen), SizedBox(width: 10)]),
        ],
        actionsPadding: EdgeInsets.symmetric(horizontal: 20),
      ),
      body: Center(child: SingleChildScrollView(child: child)),
      backgroundColor: colors.tertiaryFixedDim,
    );
  }
}
