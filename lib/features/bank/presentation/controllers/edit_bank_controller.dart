import 'package:get/get.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:mpdam/features/bank/domain/entities/update_bank_entity.dart';
import 'package:mpdam/features/bank/domain/usecases/get_bank_by_id_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/update_bank_usecase.dart';

class EditBankController extends GetxController {
  final GetBankByIdUseCase getBankByIdUseCase;
  final UpdateBankUseCase updateBankUseCase;

  EditBankController({
    required this.getBankByIdUseCase,
    required this.updateBankUseCase,
  });

  /// Reactive variables
  var bank = Rxn<Bank>();          // Rxn = nullable reactive
  var isLoading = false.obs;
  var isUpdating = false.obs;
  var errorMessage = ''.obs;

  /// Load bank data by ID
  Future<void> loadBank(String bankId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await getBankByIdUseCase(bankId);

      result.fold(
        (failure) => errorMessage.value = failure.message,
        (data) => bank.value = data,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Update bank data
  Future<bool> updateBank({
    required String bankCode,
    required String bankName,
  }) async {
    final currentBank = bank.value;
    if (currentBank == null) return false;

    final updatedEntity = UpdateBankEntity(
      oid: currentBank.oid,
      bankCode: bankCode,
      bankName: bankName,
    );

    try {
      isUpdating.value = true;
      errorMessage.value = '';

      final result = await updateBankUseCase(updatedEntity);

      bool success = false;

      result.fold(
        (failure) => errorMessage.value = failure.message,
        (_) {
          bank.value = Bank(
            oid: currentBank.oid,
            bankCode: updatedEntity.bankCode,
            bankName: updatedEntity.bankName,
            createdAt: currentBank.createdAt,
            updatedAt: DateTime.now(),
          );

          success = true;
        },
      );

      return success;
    } finally {
      isUpdating.value = false;
    }
  }
}
