import 'package:dice_pizza/domain/entities/order.dart';
import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/bloc/order_database/order_database_bloc.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_user_provider.dart';
import 'package:dice_pizza/presentation/widgets/order_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NewOrderScreen extends ConsumerWidget {
  static const name = "CreateOrder";
  const NewOrderScreen(this.child, {this.order, super.key});
  final Widget? child;
  final Order? order;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider).value?.id ?? 0;
    final userName =
        ('${ref.watch(userProvider).value?.firstName ?? 'Anonymous'} ${ref.watch(userProvider).value?.lastName ?? ''}');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  OrderDatabaseBloc(userId: userId, username: userName),
        ),
        BlocProvider(create: (context) => OrderContentsBloc()),
      ],
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: OrderBottomNavigation(),
          body: Center(child: child ?? Placeholder()),
        ),
      ),
    );
  }
}
