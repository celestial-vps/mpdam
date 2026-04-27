import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mpdam/core/storage/auth_local_datasource.dart';
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
  var isLoggedIn = false.obs;
  var errorMessage = ''.obs;

  /// CALLBACKS untuk UI
  void Function()? onLoginSuccess;
  void Function()? onLogout;
  void Function()? onAlreadyLoggedIn;

  Future<void> initLoginStatusForMain() async {
    isLoggedIn.value = await local.hasToken();

    if (isLoggedIn.value) {
      print('>>> Token ditemukan: ${local.token}');
      onAlreadyLoggedIn?.call();
    }
  }

  Future<void> login(String email, String password) async {
    // if (email.isEmpty || password.isEmpty) {
    //   errorMessage.value = "Email dan password wajib diisi";
    //   return;
    // }

    isLoading.value = true;

    final result = await loginUseCase(
      LoginParam(email: email, password: password),
    );

    isLoading.value = false;

    result.fold((failure) => errorMessage.value = failure.message, (user) {
      local.persistToken(user.token);
      isLoggedIn.value = true;
      onLoginSuccess?.call();
    });
  }

  void logout() {
    local.removeToken();
    isLoggedIn.value = false;
    onLogout?.call();
  }
}
