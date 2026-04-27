import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:mpdam/core/routing/news_routes.dart';
import 'package:mpdam/features/auth/presentation/controllers/login_controller.dart';
import 'package:mpdam/core/routing/auth_routes.dart';
import 'package:mpdam/core/routing/home_routes.dart';
import 'package:mpdam/core/routing/bank_routes.dart';
import 'package:mpdam/core/routing/customer_routes.dart';
import 'package:mpdam/core/routing/product_routes.dart';
import 'package:mpdam/core/routing/cart_routes.dart';
import '../utils/go_router_refresh_stream.dart';

// Ambil controller global
// final loginController = Get.find<LoginController>();
LoginController get loginController => Get.find<LoginController>();
final goRouterGetX = GoRouter(
  initialLocation: '/login',
  refreshListenable: GoRouterRefreshStream(loginController.isLoggedIn.stream),
  redirect: (context, state) {
    final isAuth = loginController.isLoggedIn.value;
    final loggingIn = ['/login', '/register'].contains(state.uri.path);

    if (isAuth && loggingIn) return '/home';
    if (!isAuth && !loggingIn) return '/login';

    return null;
  },
  routes: [
    ...authRoutes,
    ...homeRoutes,
    ...newsRoutes,
    ...bankRoutes,
    ...customerRoutes,
    ...productRoutes,
    ...cartRoutes,
  ],
);
