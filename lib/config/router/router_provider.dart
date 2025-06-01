import 'package:dice_pizza/config/router/navigation_constants.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_auth_provider.dart';
import 'package:dice_pizza/presentation/providers/dummyapi/dummy_api_user_provider.dart';
import 'package:dice_pizza/presentation/screens/home_screen.dart';
import 'package:dice_pizza/presentation/screens/login_screen.dart';
import 'package:dice_pizza/presentation/screens/new_order_screen.dart';
import 'package:dice_pizza/presentation/screens/profile_screen.dart';
import 'package:dice_pizza/presentation/views/order_ingredient_view.dart';
import 'package:dice_pizza/presentation/views/order_payment_view.dart';
import 'package:dice_pizza/presentation/views/order_products_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod/riverpod.dart';

final routerProvider = Provider((ref) {
  return _router(
    redirect: (context, state) {
      final AuthStatus status = ref.read(authProvider);
      if (status != AuthStatus.authenticated) {
        if (state.matchedLocation == RouterPaths.profile) {
          final bool refreshable =
              ref.read(tokenProvider)['refreshToken'] != '';
          if (!refreshable) {
            if (ref.read(authProvider) == AuthStatus.guest) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    '¡Inicia sesión para ver tu perfil!',
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
            return RouterPaths.login;
          }
        }
      }
      return null;
    },
  );
});

GoRouter _router({GoRouterRedirect? redirect}) => GoRouter(
  redirect: redirect,
  initialLocation: RouterPaths.login,
  routes: _routes,
);

List<RouteBase> _routes = [
  GoRoute(
    path: '/',
    builder: (context, state) => const LoginScreen(),
    routes: [
      GoRoute(
        path: 'u',
        name: HomeScreen.name,
        builder: (context, state) => const HomeScreen(),
        routes: _orderCreationFlow,
      ),
    ],
  ),
];

List<RouteBase> _orderCreationFlow = [
  GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
  ShellRoute(
    builder: (context, state, child) => NewOrderScreen(child, null),
    routes: [
      GoRoute(
        path: '/order/ingredients',
        builder: (context, state) => const OrderIngredientView(),
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
