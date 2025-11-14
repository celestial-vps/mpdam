import 'package:get/get.dart';
import 'package:mpdam/features/bank/domain/usecases/delete_delete_usecase.dart';

class DeleteBankController extends GetxController {
  final DeleteBankUseCase deleteBankUseCase;

  DeleteBankController({required this.deleteBankUseCase});

  var isDeleting = false.obs;

  /// Hanya mengembalikan true jika sukses, false jika gagal
  Future<bool> deleteBank(String bankId) async {
    try {
      isDeleting.value = true;

      final result = await deleteBankUseCase.call(bankId);

      return result.fold(
        (failure) => false, // UI yang tangani snackbar
        (_) => true,
      );
    } finally {
      isDeleting.value = false;
    }
  }
}
