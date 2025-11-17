import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mpdam/core/storage/auth_local_datasource.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/auth/domain/usecases/login_usecase.dart';
import 'package:mpdam/features/auth/domain/usecases/check_signin_usecase.dart';
import 'package:mpdam/features/auth/domain/entities/login_param.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;
  final CheckSigninUseCase checkSigninUseCase;
  final AuthLocalDataSource local;

  LoginController({
    required this.loginUseCase,
    required this.checkSigninUseCase,
    required this.local,
  });

  var isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  /// Method khusus untuk main.dart sebelum runApp
  Future<void> initLoginStatusForMain() async {
    isLoggedIn.value = await local.hasToken();
    if (isLoggedIn.value) {
      print('>>> Token ditemukan: ${local.token}');
    }
  }

  Future<void> login(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return _showError(context, "Email dan password wajib diisi");
    }

    isLoading.value = true;

    final result = await loginUseCase(LoginParam(email: email, password: password));

    isLoading.value = false;

    result.fold(
      (failure) => _showError(context, failure.message),
      (user) {
        local.persistToken(user.token);
        isLoggedIn.value = true;
        print('>>> Login sukses, token: ${user.token}');
        GoRouter.of(context).go('/home');
      },
    );
  }

  void logout(BuildContext context) {
    local.removeToken();
    isLoggedIn.value = false;
    print('>>> User logout');
    GoRouter.of(context).go('/login');
  }

  void _showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
