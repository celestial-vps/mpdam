import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';

class CustomerState {
  final List<Customer> customers;
  final bool isLoading;
  final bool isLoadMore;
  // final bool isSearching; // baru
  final int pageIndex;
  final int totalPages;
  final String errorMessage;

  const CustomerState({
    this.customers = const [],
    this.isLoading = false,
    this.isLoadMore = false,
    // this.isSearching = false, // default false
    this.pageIndex = 1,
    this.totalPages = 1,
    this.errorMessage = '',
  });

  CustomerState copyWith({
    List<Customer>? customers,
    bool? isLoading,
    bool? isLoadMore,
    // bool? isSearching, // baru
    int? pageIndex,
    int? totalPages,
    String? errorMessage,
  }) {
    return CustomerState(
      customers: customers ?? this.customers,
      isLoading: isLoading ?? this.isLoading,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      // isSearching: isSearching ?? this.isSearching,
      pageIndex: pageIndex ?? this.pageIndex,
      totalPages: totalPages ?? this.totalPages,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
