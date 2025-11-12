// lib/features/customer/presentation/bloc/customer/customer_state.dart
import 'package:equatable/equatable.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';

class CustomerState extends Equatable {
  final List<Customer> customers;
  final bool isLoading;
  final bool isLoadMore;
  final int pageIndex;
  final int totalPages;
  final String errorMessage;

  const CustomerState({
    this.customers = const [],
    this.isLoading = false,
    this.isLoadMore = false,
    this.pageIndex = 1,
    this.totalPages = 1,
    this.errorMessage = '',
  });

  CustomerState copyWith({
    List<Customer>? customers,
    bool? isLoading,
    bool? isLoadMore,
    int? pageIndex,
    int? totalPages,
    String? errorMessage,
  }) {
    return CustomerState(
      customers: customers ?? this.customers,
      isLoading: isLoading ?? this.isLoading,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      pageIndex: pageIndex ?? this.pageIndex,
      totalPages: totalPages ?? this.totalPages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        customers,
        isLoading,
        isLoadMore,
        pageIndex,
        totalPages,
        errorMessage,
      ];
}
