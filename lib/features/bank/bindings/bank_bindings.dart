// FILE: features/bank/bindings/bank_bindings.dart
import 'package:get/get.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';
import 'package:mpdam/features/bank/domain/usecases/create_bank_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/delete_delete_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/get_bank_by_id_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/list_bank_usecase.dart';
import 'package:mpdam/features/bank/domain/usecases/update_bank_usecase.dart';
import 'package:mpdam/features/bank/presentation/controllers/add_bank_controller.dart';
import 'package:mpdam/features/bank/presentation/controllers/bank_controller.dart';
import 'package:mpdam/features/bank/presentation/controllers/delete_bank_controller.dart';
import 'package:mpdam/features/bank/presentation/controllers/edit_bank_controller.dart';

class BankBindings {
  static void init() {
    // ===========================
    // Controllers
    // ===========================
    Get.lazyPut<BankController>(
      () => BankController(getInitBankUseCase: GetInitBankUseCase(sl())),
      fenix: true,
    );

    Get.lazyPut<EditBankController>(
      () => EditBankController(
        getBankByIdUseCase: GetBankByIdUseCase(sl()),
        updateBankUseCase: UpdateBankUseCase(sl()),
      ),
      fenix: false,
    );

    Get.lazyPut<DeleteBankController>(
      () => DeleteBankController(
        deleteBankUseCase: DeleteBankUseCase(sl()),
      ),
      fenix: false,
    );

    Get.lazyPut<AddBankController>(
      () => AddBankController(
        createBankUseCase: CreateBankUseCase(sl()),
      ),
      fenix: true,
    );
  }
}
