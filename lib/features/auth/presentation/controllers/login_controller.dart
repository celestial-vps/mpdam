import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/auth/domain/entities/login_param.dart';
import 'package:mpdam/features/auth/domain/usecases/login_usecase.dart';

class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController({required this.loginUseCase});

  var isLoading = false.obs;

  Future<void> login(BuildContext context, String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      return _showError(context, "Email dan password wajib diisi");
    }

    isLoading.value = true;

    final result = await loginUseCase(LoginParam(email: email, password: password));

    isLoading.value = false;

    result.fold(
      (failure) => _showError(context, failure.message),
      (user) => GoRouter.of(context).go('/home'),
    );
  }

  void _showError(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
