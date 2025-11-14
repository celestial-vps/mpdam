import 'package:get/get.dart';
import 'package:mpdam/features/bank/domain/usecases/create_bank_usecase.dart';
import 'package:mpdam/features/bank/domain/entities/create_bank_entity.dart';


class AddBankController extends GetxController {
  final CreateBankUseCase createBankUseCase;

  AddBankController({required this.createBankUseCase});

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var successMessage = ''.obs;
  var isSubmitted = false.obs;

  Future<void> submitBank(CreateBankEntity bank) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      successMessage.value = '';

      final result = await createBankUseCase.call(bank);
      result.fold(
        (failure) => errorMessage.value = failure.message,
        (_) {
          successMessage.value = 'Bank berhasil ditambahkan';
          isSubmitted.value = true;
        },
      );
    } finally {
      isLoading.value = false;
    }
  }
}
