import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:mpdam/features/customer/domain/entities/create_customer_entity.dart';
import 'package:mpdam/features/customer/domain/usecases/create_customer_usecase.dart';
import 'package:mpdam/core/error/failure.dart';

class AddCustomerController extends GetxController {
  final CreateCustomerUseCase createCustomerUseCase;

  AddCustomerController({required this.createCustomerUseCase});

  /// TextField controllers
  final firstNameController = TextEditingController(text: "Alex");
  final middleNameController = TextEditingController(text: "Abad");
  final lastNameController = TextEditingController(text: "Dalem");
  final emailController = TextEditingController(text: "alex@gmail.com");
  final phoneController = TextEditingController(text: "012938123123");
  final addressController = TextEditingController(text: "Jl Sukapura no 68");

  /// State management (observable)
  final isLoading = false.obs;
  final errorMessage = ''.obs;
  final successMessage = ''.obs;

  /// Tambah customer ke backend
  Future<bool> addCustomer() async {
    // Validasi sederhana di sisi client
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty) {
      errorMessage.value = 'Nama dan email tidak boleh kosong.';
      return false;
    }

    isLoading.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    final data = CreateCustomerEntity(
      firstName: firstNameController.text.trim(),
      middleName: middleNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      phoneNumber: phoneController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
    );

    final result = await createCustomerUseCase(data);

    bool success = false;

    result.fold(
      (failure) {
        errorMessage.value = _failureMessage(failure);
      },
      (_) {
        // successMessage.value = 'Customer berhasil ditambahkan.';
        success = true;
      },
    );

    isLoading.value = false;
    return success;
  }

  /// Pesan error yang lebih deskriptif
  String _failureMessage(Failure failure) {
    return failure.message ?? 'Terjadi kesalahan pada server.';
  }

  /// Membersihkan semua field
  void clearFields() {
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    addressController.clear();
  }

  @override
  void onClose() {
    // Pastikan semua controller di-dispose agar tidak memory leak
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }
}
