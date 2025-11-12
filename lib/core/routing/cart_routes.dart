// lib/core/router/cart_routes.dart
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/cart/presentation/cart_page.dart';
import 'package:mpdam/features/payment/presentation/payment_page.dart';

final cartRoutes = [
  GoRoute(
    path: '/cart',
    builder: (context, state) => const CartPage(),
    routes: [
      GoRoute(
        path: 'payment',
        builder: (context, state) => const PaymentPage(),
      ),
    ],
  ),
];
