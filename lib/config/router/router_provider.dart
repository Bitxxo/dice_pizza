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

List<RouteBase> _routes = [
  GoRoute(
    path: '/',
    name: HomeScreen.name,
    builder: (context, state) => const HomeScreen(),
    routes: _orderCreationFlow,
  ),
];

List<RouteBase> _orderCreationFlow = [
  ShellRoute(
    builder: (context, state, child) => OrderScreen(child, null),
    routes: [
      GoRoute(
        path: '/order/customer',
        builder: (context, state) => const OrderCustomerView(),
      ),
      GoRoute(
        path: '/order/products',
        builder: (context, state) => const OrderProductsView(),
      ),
      GoRoute(
        path: '/order/payment',
        builder: (context, state) => const OrderPaymentView(),
      ),
    ],
  ),
];
