// import 'package:equatable/equatable.dart';
// import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';


// class SearchCustomerState extends Equatable {
//   final bool isLoading;
//   final List<Customer> results;
//   final String query;
//   final String errorMessage;

//   const SearchCustomerState({
//     this.isLoading = false,
//     this.results = const [],
//     this.query = '',
//     this.errorMessage = '',
//   });

//   SearchCustomerState copyWith({
//     bool? isLoading,
//     List<Customer>? results,
//     String? query,
//     String? errorMessage,
//   }) {
//     return SearchCustomerState(
//       isLoading: isLoading ?? this.isLoading,
//       results: results ?? this.results,
//       query: query ?? this.query,
//       errorMessage: errorMessage ?? this.errorMessage,
//     );
//   }

//   @override
//   List<Object?> get props => [isLoading, results, query, errorMessage];
// }
