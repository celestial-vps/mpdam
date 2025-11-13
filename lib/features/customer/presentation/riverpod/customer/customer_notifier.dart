import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mpdam/features/customer/domain/entities/customer_search_param.dart';
import 'package:mpdam/features/customer/domain/usecases/get_all_customer_usecase.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'customer_state.dart';

class CustomerNotifier extends StateNotifier<CustomerState> {
  final GetInitCustomerUseCase getInitCustomerUseCase;
  Timer? _debounce;
  String? _lastSearchQuery;

  CustomerNotifier(this.getInitCustomerUseCase) : super(const CustomerState()) {
    fetchCustomers();
  }

  // Future<void> fetchCustomers({
  //   bool refresh = false,
  //   CustomerSearchParam? searchParam,
  // }) async {
  //   state = state.copyWith(isLoading: true, errorMessage: '');
  //   final page = refresh ? 1 : state.pageIndex;

  //   // Gunakan searchParam jika ada, kalau tidak gunakan default
  //   final param =
  //       searchParam ??
  //       CustomerSearchParam(
  //         pagination: PaggingParam(pageIndex: page, pageSize: 10),
  //       );

  //   // Copy pagination dan attach search dinamis
  //   final paggingWithSearch = param.pagination.copyWith(
  //     search: param.search, // langsung pakai map dari UI
  //   );

  //   // Debug log
  //   print('=== BODY TO SEND ===');
  //   print(paggingWithSearch.search);

  //   // final result = await getInitCustomerUseCase(
  //   //   param.pagination.copyWith(
  //   //     search: param.search != null ? {'query': param.search} : null,
  //   //   ),
  //   // );

  //   final result = await getInitCustomerUseCase(paggingWithSearch);

  //   result.fold(
  //     (failure) {
  //       state = state.copyWith(
  //         isLoading: false,
  //         errorMessage: failure.message ?? 'Terjadi kesalahan',
  //       );
  //     },
  //     (data) {
  //       state = state.copyWith(
  //         isLoading: false,
  //         customers: refresh ? data.data : [...state.customers, ...data.data],
  //         totalPages: data.pagination.totalPage,
  //         pageIndex: page,
  //       );
  //     },
  //   );
  // }

  Future<void> fetchCustomers({
    bool refresh = false,
    CustomerSearchParam? searchParam,
  }) async {
    // jika ada search, set isSearching true
    // final searching =
    //     searchParam?.search != null && searchParam!.search!.isNotEmpty;

    state = state.copyWith(
      isLoading: true,
      errorMessage: '',
      // isSearching: searching,
    );

    final page = refresh ? 1 : state.pageIndex;
    final param =
        searchParam ??
        CustomerSearchParam(
          pagination: PaggingParam(pageIndex: page, pageSize: 10),
        );

    final paggingWithSearch = param.pagination.copyWith(search: param.search);

    final result = await getInitCustomerUseCase(paggingWithSearch);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          // isSearching: false, // selesai searching
          errorMessage: failure.message ?? 'Terjadi kesalahan',
        );
      },
      (data) {
        state = state.copyWith(
          isLoading: false,
          // isSearching: false, // selesai searching
          customers: refresh ? data.data : [...state.customers, ...data.data],
          totalPages: data.pagination.totalPage,
          pageIndex: page,
        );
      },
    );
  }

  Future<void> loadMore() async {
    if (state.isLoadMore || state.pageIndex >= state.totalPages) return;

    state = state.copyWith(isLoadMore: true);
    final nextPage = state.pageIndex + 1;

    final result = await getInitCustomerUseCase(
      PaggingParam(pageIndex: nextPage, pageSize: 10),
    );

    result.fold(
      (failure) => state = state.copyWith(errorMessage: failure.message),
      (data) {
        state = state.copyWith(
          customers: [...state.customers, ...data.data],
          pageIndex: nextPage,
        );
      },
    );

    state = state.copyWith(isLoadMore: false);
  }
}
