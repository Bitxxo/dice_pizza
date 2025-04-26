import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:dice_pizza/presentation/screens/home_screen.dart';
import 'package:dice_pizza/presentation/screens/order_screen.dart';
import 'package:dice_pizza/presentation/views/order_customer_view.dart';
import 'package:dice_pizza/presentation/views/order_payment_view.dart';
import 'package:dice_pizza/presentation/views/order_products_view.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

final routerProvider = Provider((ref) {
  return _router();
});

GoRouter _router({GoRouterRedirect? redirect}) => GoRouter(
  redirect: redirect,
  initialLocation: RouterPaths.home,
  routes: _routes,
);

List<GoRoute> _routes = [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
    routes: [
      GoRoute(
        path: 'order',
        name: OrderScreen.name,
        builder: (context, state) => OrderScreen(),
        routes: [
          GoRoute(
            path: '/customer',
            name: OrderCustomerView.name,
            builder: (context, state) => const OrderCustomerView(),
          ),
          GoRoute(
            path: '/products',
            name: OrderProductsView.name,
            builder: (context, state) => const OrderProductsView(),
          ),
          /*
          GoRoute(
            path: '/ingredients',
            name: OrderProductsView.name,
            builder: (context, state) => const OrderProductsView(),
          ),
          */
          GoRoute(
            path: '/payment',
            name: OrderPaymentView.name,
            builder: (context, state) => const OrderPaymentView(),
          ),
        ],
      ),
    ],
  ),
];
