// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:mpdam/service_locator.dart'; // pastikan path sesuai project
// import 'package:mpdam/features/auth/presentation/controllers/auth_controller.dart';
// import 'package:mpdam/core/routing/app_router.dart'; // berisi GetPage routes

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Inisialisasi semua dependency di GetIt
//   await initDependencyInjection();
//   await sl.allReady(); // tunggu semua async singleton siap

//   // Inject controller GetX dari GetIt
//   Get.put(sl<AuthController>(), permanent: true);

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Login App - GetX',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData.light(),

//       // Routing GetX
//       getPages: AppRouter.routes,       // List<GetPage> dari AppRouter
//       initialRoute: AppRouter.initialRoute,
//     );
//   }
// }
