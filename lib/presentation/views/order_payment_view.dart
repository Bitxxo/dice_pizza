import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/widgets/order_editing_scaffold.dart';
import 'package:dice_pizza/presentation/widgets/payment_form.dart';
import 'package:dice_pizza/presentation/widgets/product/order_payment_products_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPaymentView extends StatelessWidget {
  static const name = 'Payment';
  const OrderPaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final isBigScreen = MediaQuery.of(context).size.width > 700;
    final paid = context.watch<OrderContentsBloc>().state.paid;
    final isEmpty = context.watch<OrderContentsBloc>().state.products.isEmpty;
    final size = MediaQuery.of(context).size;
    return OrderEditingScaffold(
      title: 'Pago',
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            isEmpty
                ? Center(
                  child: Text(
                    '¡Añade algún producto primero!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30),
                  ),
                )
                : Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 20,
                    children:
                        isBigScreen
                            ? [
                              SizedBox(
                                width: size.width * 0.35,
                                child: PaymentForm(),
                              ),
                              SizedBox(width: 100),
                              Column(
                                children: [
                                  OrderPaymentProductsList(),
                                  _PaidText(paid: paid),
                                ],
                              ),

                              //  SizedBox(width: 100),
                            ]
                            : [PaymentForm()],
                  ),
                ),
      ),
    );
  }
}

class _PaidText extends StatelessWidget {
  const _PaidText({required this.paid});

  final bool paid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            paid ? 'PEDIDO PAGADO' : 'NO PAGADO',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
