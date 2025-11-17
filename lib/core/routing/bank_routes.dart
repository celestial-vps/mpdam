// lib/core/router/home_routes.dart
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/bank/bindings/bank_bindings.dart';
import 'package:mpdam/features/bank/presentation/pages/add_bank_page.dart';
import 'package:mpdam/features/bank/presentation/pages/bank_page.dart';
import 'package:mpdam/features/bank/presentation/pages/edit_bank_page.dart';
// BankBindings.init(); hapus semua code ini jika ingin rubah  state management selain getx controller tidak perlu di simpan di service locator agak rumit maintenancenya code nya
final bankRoutes = [
GoRoute(
  path: '/bank',
  builder: (context, state) {
    BankBindings.init();
    return BankPage();
  },
),
GoRoute(
  path: '/add-bank',
  builder: (context, state) {
    BankBindings.init();
    return AddBankPage();
  },
),
GoRoute(
  path: '/edit-bank',
  builder: (context, state) {
    BankBindings.init();
    final bankId = state.extra as String;
    return EditBankPage(bankId: bankId);
  },
),

];
