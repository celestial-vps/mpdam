import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mpdam/core/routing/app_router_getx.dart';
import 'core/dependency_injection/service_locator.dart';
import 'features/auth/presentation/controllers/login_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencyInjection();
  await sl.allReady();

  // Inisialisasi LoginController via GetX
  final loginController = Get.put(
    LoginController(loginUseCase: sl(), checkSigninUseCase: sl(), local: sl()),
    permanent: true,
  );

  // Cek token sebelum runApp
  await loginController.initLoginStatusForMain();

  final router = goRouterGetX; // setelah loginController di-Put
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final GoRouter router;

  const MyApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MPDAM App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
