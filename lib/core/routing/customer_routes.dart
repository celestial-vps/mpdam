// lib/core/router/home_routes.dart
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/customer/presentation/pages/add_customer_page.dart';
import 'package:mpdam/features/customer/presentation/pages/customer_page.dart';
import 'package:mpdam/features/customer/presentation/pages/edit_customer_page.dart';

final customerRoutes = [
  GoRoute(path: '/customer', builder: (context, state) => CustomerPage()),
  GoRoute(
    path: '/add-customer',
    builder: (context, state) => AddCustomerPage(),
  ),
  GoRoute(
    path: '/edit-customer',
    builder: (context, state) {
      final customerId = state.extra as String; // kirim id saja
      return EditCustomerPage(customerId: customerId);
    },
  ),

];
