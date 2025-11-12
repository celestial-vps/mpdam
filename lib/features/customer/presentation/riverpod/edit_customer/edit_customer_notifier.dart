import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';
import 'package:mpdam/features/customer/domain/entities/update_customer_entity.dart';
import 'package:mpdam/features/customer/domain/usecases/get_customer_by_id_usecase.dart';
import 'package:mpdam/features/customer/domain/usecases/update_customer_usecase.dart';
import 'edit_customer_state.dart';

class EditCustomerNotifier extends StateNotifier<EditCustomerState> {
  final GetCustomerByIdUseCase getCustomerByIdUseCase;
  final UpdateCustomerUseCase updateCustomerUseCase;

  EditCustomerNotifier({
    required this.getCustomerByIdUseCase,
    required this.updateCustomerUseCase,
  }) : super(EditCustomerState.initial());

  /// 🔹 Ambil customer berdasarkan ID
  Future<void> loadCustomer(String customerId) async {
    state = state.copyWith(isLoading: true);

    final result = await getCustomerByIdUseCase(customerId);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.toString(),
      ),
      (customer) => state = state.copyWith(
        isLoading: false,
        customer: customer,
      ),
    );
  }

  /// 🔹 Update data customer
  Future<void> updateCustomer(Customer updatedCustomer) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await updateCustomerUseCase(
      UpdateCustomerEntity(
        oid: updatedCustomer.oid,
        firstName: updatedCustomer.firstName,
        middleName: updatedCustomer.middleName,
        lastName: updatedCustomer.lastName,
        email: updatedCustomer.email,
        phoneNumber: updatedCustomer.phoneNumber,
        address: updatedCustomer.address,
      ),
    );

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.toString(),
      ),
      (_) => state = state.copyWith(
        isLoading: false,
        customer: updatedCustomer,
      ),
    );
  }
}
