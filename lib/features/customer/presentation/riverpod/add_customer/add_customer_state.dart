class AddCustomerState {
  final bool isLoading;
  final bool isSubmitted;
  final String errorMessage;
  final String successMessage;

  const AddCustomerState({
    this.isLoading = false,
    this.isSubmitted = false,
    this.errorMessage = '',
    this.successMessage = '',
  });

  AddCustomerState copyWith({
    bool? isLoading,
    bool? isSubmitted,
    String? errorMessage,
    String? successMessage,
  }) {
    return AddCustomerState(
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
    );
  }
}
