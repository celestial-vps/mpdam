import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'delete_customer_notifier.dart';
import 'package:mpdam/service_locator.dart';
import 'package:mpdam/features/customer/domain/usecases/delete_customer_usecase.dart';

final deleteCustomerProvider =
    StateNotifierProvider<DeleteCustomerNotifier, DeleteCustomerState>((ref) {
  final usecase = sl<DeleteCustomerUseCase>();
  return DeleteCustomerNotifier(usecase);
});
