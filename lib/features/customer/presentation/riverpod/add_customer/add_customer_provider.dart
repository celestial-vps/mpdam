import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';
import 'add_customer_notifier.dart';
import 'add_customer_state.dart'; 

final addCustomerProvider =
    StateNotifierProvider<AddCustomerNotifier, AddCustomerState>(
  (ref) => AddCustomerNotifier(createCustomerUseCase: sl()),
);
