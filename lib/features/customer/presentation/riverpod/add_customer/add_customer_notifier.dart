import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/features/customer/domain/entities/create_customer_entity.dart';
import 'package:mpdam/features/customer/domain/usecases/create_customer_usecase.dart';
import 'add_customer_state.dart';

class AddCustomerNotifier extends StateNotifier<AddCustomerState> {
  final CreateCustomerUseCase createCustomerUseCase;

  AddCustomerNotifier({required this.createCustomerUseCase}) : super(const AddCustomerState());

  Future<void> submitCustomer(CreateCustomerEntity customer) async {
    state = state.copyWith(isLoading: true, errorMessage: '', successMessage: '');
    final result = await createCustomerUseCase(customer);
    result.fold(
      (failure) => state = state.copyWith(
          isLoading: false, errorMessage: failure.toString(), successMessage: ''),
      (_) => state = state.copyWith(
          isLoading: false, isSubmitted: true, successMessage: 'Customer berhasil ditambahkan'),
    );
  }
}
