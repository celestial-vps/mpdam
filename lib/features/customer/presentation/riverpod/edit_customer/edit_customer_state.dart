import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';

class EditCustomerState {
  final bool isLoading;        // untuk load data customer by id
  final bool isUpdating;       // untuk status update
  final Customer? customer;    // data customer
  final String errorMessage;   // pesan error

  EditCustomerState({
    required this.isLoading,
    required this.isUpdating,
    required this.customer,
    required this.errorMessage,
  });

  /// initial state
  factory EditCustomerState.initial() => EditCustomerState(
        isLoading: false,
        isUpdating: false,
        customer: null,
        errorMessage: '',
      );

  /// copyWith agar mudah ubah sebagian field
  EditCustomerState copyWith({
    bool? isLoading,
    bool? isUpdating,
    Customer? customer,
    String? errorMessage,
  }) {
    return EditCustomerState(
      isLoading: isLoading ?? this.isLoading,
      isUpdating: isUpdating ?? this.isUpdating,
      customer: customer ?? this.customer,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
