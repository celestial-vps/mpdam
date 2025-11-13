import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:mpdam/core/routing/app_router_getx.dart';
import 'package:mpdam/service_locator.dart';

// GETX & BLOC
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencyInjection();
  await sl.allReady();

  runApp(const MyApp());
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize GetIt / DI
//   await initDependencyInjection();
//   await sl.allReady(); // optional, waits until all async dependencies are ready

//   runApp(ProviderScope(child: MyApp()));
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'MPDAM App - GetX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),

      // Untuk GoRouter < 6 / Flutter < 3.7
      routerDelegate: goRouterGetX.routerDelegate,
      routeInformationParser: goRouterGetX.routeInformationParser,
      routeInformationProvider: goRouterGetX.routeInformationProvider,
    );
  }
}
