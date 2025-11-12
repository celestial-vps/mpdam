// lib/features/customer/presentation/bloc/customer/customer_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/customer/domain/usecases/get_all_customer_usecase.dart';
import 'customer_event.dart';
import 'customer_state.dart';

class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetInitCustomerUseCase getInitCustomerUseCase;

  CustomerBloc({required this.getInitCustomerUseCase})
      : super(const CustomerState()) {
    on<FetchCustomers>(_onFetchCustomers);
    on<LoadMoreCustomers>(_onLoadMore);
  }

  Future<void> _onFetchCustomers(
    FetchCustomers event,
    Emitter<CustomerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: ''));

    final currentPage = event.refresh ? 1 : state.pageIndex;
    final result = await getInitCustomerUseCase(
      PaggingParam(pageIndex: currentPage, pageSize: 10),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: _failureMessage(failure),
      )),
      (data) {
        emit(state.copyWith(
          isLoading: false,
          customers: event.refresh
              ? data.data
              : [...state.customers, ...data.data],
          pageIndex: currentPage,
          totalPages: data.pagging.totalPage,
        ));
      },
    );
  }

  Future<void> _onLoadMore(
    LoadMoreCustomers event,
    Emitter<CustomerState> emit,
  ) async {
    if (state.isLoadMore || state.pageIndex >= state.totalPages) return;

    emit(state.copyWith(isLoadMore: true, errorMessage: ''));

    final nextPage = state.pageIndex + 1;
    final result = await getInitCustomerUseCase(
      PaggingParam(pageIndex: nextPage, pageSize: 10),
    );

    result.fold(
      (failure) => emit(state.copyWith(
        isLoadMore: false,
        errorMessage: _failureMessage(failure),
      )),
      (data) {
        emit(state.copyWith(
          isLoadMore: false,
          pageIndex: nextPage,
          totalPages: data.pagging.totalPage,
          customers: [...state.customers, ...data.data],
        ));
      },
    );
  }

  String _failureMessage(Failure failure) =>
      failure.message ?? 'Terjadi kesalahan';
}
