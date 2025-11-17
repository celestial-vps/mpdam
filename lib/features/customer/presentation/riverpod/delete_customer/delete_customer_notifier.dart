import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/features/customer/domain/usecases/delete_customer_usecase.dart';

class DeleteCustomerState {
  final bool isLoading;
  final String errorMessage;

  const DeleteCustomerState({this.isLoading = false, this.errorMessage = ''});

  DeleteCustomerState copyWith({bool? isLoading, String? errorMessage}) {
    return DeleteCustomerState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class DeleteCustomerNotifier extends StateNotifier<DeleteCustomerState> {
  final DeleteCustomerUseCase deleteCustomerUseCase;

  DeleteCustomerNotifier(this.deleteCustomerUseCase)
    : super(const DeleteCustomerState());

  Future<bool> deleteCustomer(String customerId) async {
    state = state.copyWith(isLoading: true, errorMessage: '');
    final result = await deleteCustomerUseCase(customerId);

    bool success = false;
    result.fold(
      (failure) =>
          state = state.copyWith(errorMessage: failure.message ?? 'Error'),
      (data) => success = true,
    );

    state = state.copyWith(isLoading: false);
    return success;
  }
}
