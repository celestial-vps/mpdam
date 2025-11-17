// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mpdam/core/storage/auth_local_datasource.dart';
// import 'package:mpdam/features/auth/presentation/controllers/login_controller.dart';
// import 'package:mpdam/features/home/presentation/home_page.dart';
// import 'core/dependency_injection/service_locator.dart'; 
// import 'features/auth/presentation/pages/login_page.dart';

// class InitialPage extends StatelessWidget {
//   const InitialPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Future.delayed(Duration.zero, () {
//       final authLocal = sl<AuthLocalDataSource>();

//       if (authLocal.isLoggedIn) {
//         Get.offAll(() => HomePage());
//       } else {
//         // buat controller dulu
//         final loginController = Get.put(
//           LoginController(
//             loginUseCase: sl(),
//             local: sl(),
//           ),
//           tag: 'login',
//           permanent: true,
//         );

//         Get.offAll(() => LoginPage(controller: loginController));
//       }
//     });

//     return const Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

