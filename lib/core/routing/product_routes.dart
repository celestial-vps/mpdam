// lib/core/router/product_routes.dart
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/cart/presentation/cart_page.dart';
import 'package:mpdam/features/payment/presentation/payment_page.dart';
import '../../features/product/presentation/product_list_page.dart';
import '../../features/product/presentation/product_detail_page.dart';

final productRoutes = [
  GoRoute(
    path: '/product',
    builder: (context, state) => const ProductListPage(),
    routes: [
      GoRoute(
        path: ':id',
        builder: (context, state) {
          // final id = state.pathParameters['id']!;
          // return ProductDetailPage(productId: id);
          return ProductDetailPage();
        },
        routes: [
          GoRoute(
            path: 'cart',
            builder: (context, state) => const CartPage(),
          ),
          GoRoute(
            path: 'payment',
            builder: (context, state) => const PaymentPage(),
          ),
        ],
      ),
    ],
  ),
];
