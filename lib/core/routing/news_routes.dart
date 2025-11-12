import 'package:go_router/go_router.dart';
import 'package:mpdam/features/customer/presentation/pages/customer_page.dart';

final newsRoutes = [
  GoRoute(path: '/news', builder: (context, state) =>   CustomerPage()),  
];
