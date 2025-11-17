import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';
import 'customer_notifier.dart';
import 'customer_state.dart';
import 'package:mpdam/features/customer/domain/usecases/get_all_customer_usecase.dart';

final customerNotifierProvider =
    StateNotifierProvider<CustomerNotifier, CustomerState>((ref) {
  final usecase = sl<GetInitCustomerUseCase>();
  return CustomerNotifier(usecase);
});
