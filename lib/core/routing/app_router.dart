// lib/core/router/app_router.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/auth_provider.dart';
import '../utils/go_router_refresh_stream.dart';

// Import semua routes modular
import 'auth_routes.dart';
import 'home_routes.dart';
import 'product_routes.dart';
import 'cart_routes.dart';
import 'customer_routes.dart';

final routerProvider = Provider<GoRouter>((ref) {  
  final notifier = ref.read(authProvider.notifier);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: GoRouterRefreshStream(notifier.stream),
    // redirect: (context, state) {      
    //   return '/login';
    // },
    routes: [
      ...authRoutes,
      ...homeRoutes,
      ...customerRoutes,
      ...productRoutes,
      ...cartRoutes,
    ],
  );
});
