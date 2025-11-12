// import 'package:get/get.dart';
// import 'package:mpdam/core/error/failure.dart';
// import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';

// class DeleteCustomerController extends GetxController {
//   final CustomerRepository repository;

//   DeleteCustomerController({required this.repository});

//   var isLoading = false.obs;
//   var errorMessage = ''.obs;
//   var successMessage = ''.obs;

//   Future<void> deleteCustomer(String oid) async {
//     isLoading.value = true;
//     errorMessage.value = '';
//     successMessage.value = '';

//     final result = await repository.deleteCustomer(oid);

//     result.fold(
//       (failure) {
//         errorMessage.value = _failureMessage(failure);
//       },
//       (_) {
//         successMessage.value = "Customer berhasil dihapus";
//       },
//     );

//     isLoading.value = false;
//   }

//   String _failureMessage(Failure failure) {
//     return failure.message ?? 'Terjadi kesalahan';
//   }
// }
