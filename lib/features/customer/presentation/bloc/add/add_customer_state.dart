import 'package:equatable/equatable.dart';

class AddCustomerState extends Equatable {
  final bool isLoading;
  final String errorMessage;
  final String successMessage;
  final bool isSubmitted;

  const AddCustomerState({
    this.isLoading = false,
    this.errorMessage = '',
    this.successMessage = '',
    this.isSubmitted = false,
  });

  AddCustomerState copyWith({
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    bool? isSubmitted,
  }) {
    return AddCustomerState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      successMessage: successMessage ?? this.successMessage,
      isSubmitted: isSubmitted ?? this.isSubmitted,
    );
  }

  @override
  List<Object?> get props => [isLoading, errorMessage, successMessage, isSubmitted];
}
