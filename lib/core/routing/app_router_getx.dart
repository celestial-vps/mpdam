// lib/core/router/app_router_getx.dart
import 'package:go_router/go_router.dart';
import 'package:mpdam/core/routing/bank_routes.dart';
import 'customer_routes.dart';
import 'auth_routes.dart';
import 'home_routes.dart';
import 'product_routes.dart';
import 'cart_routes.dart';

final goRouterGetX = GoRouter(
  initialLocation: '/login',
  routes: [
    ...authRoutes,    
    ...homeRoutes,
    ...bankRoutes,
    ...customerRoutes,
    ...productRoutes,
    ...cartRoutes,
  ],
);
