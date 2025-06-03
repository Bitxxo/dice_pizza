import 'package:dice_pizza/presentation/bloc/order_contents/order_contents_bloc.dart';
import 'package:dice_pizza/presentation/bloc/order_database/order_database_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExistingOrderBlocInjection extends StatelessWidget {
  final Widget? child;
  const ExistingOrderBlocInjection(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => OrderDatabaseBloc()),
        BlocProvider(create: (context) => OrderContentsBloc()),
      ],
      child: child ?? Placeholder(),
    );
  }
}
