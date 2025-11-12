import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/customer/domain/entities/create_customer_entity.dart';
import 'package:mpdam/features/customer/domain/usecases/create_customer_usecase.dart';
import 'add_customer_event.dart';
import 'add_customer_state.dart';

class AddCustomerBloc extends Bloc<AddCustomerEvent, AddCustomerState> {
  final CreateCustomerUseCase createCustomerUseCase;

  AddCustomerBloc({required this.createCustomerUseCase})
      : super(const AddCustomerState()) {
    on<SubmitCustomer>(_onSubmitCustomer);
  }

  Future<void> _onSubmitCustomer(
    SubmitCustomer event,
    Emitter<AddCustomerState> emit,
  ) async {
    // Validasi
    if (event.firstName.isEmpty || event.lastName.isEmpty || event.email.isEmpty) {
      emit(state.copyWith(errorMessage: 'Nama dan email tidak boleh kosong.'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: '', successMessage: ''));

    final entity = CreateCustomerEntity(
      firstName: event.firstName,
      middleName: event.middleName,
      lastName: event.lastName,
      email: event.email,
      phoneNumber: event.phone,
      address: event.address,
    );

    final result = await createCustomerUseCase(entity);

    result.fold(
      (failure) => emit(state.copyWith(
        isLoading: false,
        errorMessage: _failureMessage(failure),
      )),
      (_) => emit(state.copyWith(
        isLoading: false,
        successMessage: 'Customer berhasil ditambahkan.',
        isSubmitted: true,
      )),
    );
  }

  String _failureMessage(Failure failure) {
    return failure.message ?? 'Terjadi kesalahan pada server.';
  }
}
