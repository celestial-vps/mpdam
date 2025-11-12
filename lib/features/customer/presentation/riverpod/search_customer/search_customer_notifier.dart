// import 'dart:async';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:mpdam/features/customer/domain/usecases/search_customer_usecase.dart';

// import 'search_customer_state.dart';

// class SearchCustomerNotifier extends StateNotifier<SearchCustomerState> {
//   final SearchCustomerUseCase searchCustomerUseCase;
//   Timer? _debounce;

//   SearchCustomerNotifier(this.searchCustomerUseCase)
//       : super(const SearchCustomerState());

//   /// Fungsi search dengan debounce
//   void search(String query) {
//     _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 400), () async {
//       if (query.isEmpty) {
//         state = state.copyWith(results: [], query: '', isLoading: false);
//         return;
//       }

//       state = state.copyWith(isLoading: true, query: query, errorMessage: '');
//       final result = await searchCustomerUseCase(query);

//       result.fold(
//         (failure) {
//           state = state.copyWith(
//             isLoading: false,
//             errorMessage: failure.message ?? 'Terjadi kesalahan',
//           );
//         },
//         (data) {
//           state = state.copyWith(isLoading: false, results: data);
//         },
//       );
//     });
//   }

//   @override
//   void dispose() {
//     _debounce?.cancel();
//     super.dispose();
//   }
// }
