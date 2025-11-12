// lib/core/router/app_router_riverpod.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'customer_routes.dart';
import 'auth_routes.dart';
import 'home_routes.dart';
import 'product_routes.dart';
import 'cart_routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // contoh: bisa pakai refresh untuk auth
  return GoRouter(
    initialLocation: '/login',
    routes: [
      ...authRoutes,
      ...homeRoutes,
      ...customerRoutes,
      ...productRoutes,
      ...cartRoutes,
    ],
  );
});
