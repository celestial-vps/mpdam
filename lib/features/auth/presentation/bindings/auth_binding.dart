import 'package:get/get.dart';
import 'package:mpdam/features/auth/domain/usecases/login_usecase.dart';
import 'package:mpdam/features/auth/domain/usecases/check_signin_usecase.dart';
import 'package:mpdam/features/auth/presentation/controllers/login_controller.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';

class AuthBinding {
  static void init() {
    Get.put(
      LoginController(
        loginUseCase: sl<LoginUseCase>(),
        checkSigninUseCase: sl<CheckSigninUseCase>(), // wajib
        local: sl(), // AuthLocalDataSource
      ),
      permanent: true,
    );
  }
}
