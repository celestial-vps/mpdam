import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/service_locator.dart';
import 'edit_customer_notifier.dart';
import 'edit_customer_state.dart';

final editCustomerProvider =
    StateNotifierProvider<EditCustomerNotifier, EditCustomerState>(
  (ref) => EditCustomerNotifier(
    getCustomerByIdUseCase: sl(),
    updateCustomerUseCase: sl(),
  ),
);
