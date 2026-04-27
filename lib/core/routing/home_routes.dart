import 'package:go_router/go_router.dart';
import 'package:mpdam/core/routing/bank_routes.dart';
import 'package:mpdam/core/routing/cart_routes.dart';
import 'package:mpdam/core/routing/customer_routes.dart';
import 'package:mpdam/core/routing/news_routes.dart';
import 'package:mpdam/core/routing/product_routes.dart';
import 'package:mpdam/features/home/presentation/home_page.dart';

final homeRoutes = [
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
    routes: [
      // ...bankRoutes,
      // ...newsRoutes,
      // ...productRoutes,
      // ...customerRoutes,
      // ...cartRoutes,
    ],
  ),
];
