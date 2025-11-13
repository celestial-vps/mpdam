// lib/core/router/home_routes.dart
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/bank/presentation/pages/bank_page.dart';

final bankRoutes = [
  GoRoute(path: '/bank', builder: (context, state) => BankPage()),

  // GoRoute(
  //   path: '/add-bank',
  //   builder: (context, state) => AddBankPage(),
  // ),
  // GoRoute(
  //   path: '/edit-bank',
  //   builder: (context, state) {
  //     final bankId = state.extra as String; // kirim id saja
  //     return EditBankPage(bankId: bankId);
  //   },
  // ),
];
