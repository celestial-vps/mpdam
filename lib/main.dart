import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:mpdam/core/routing/app_router_getx.dart';
import 'package:mpdam/core/dependency_injection/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initDependencyInjection();
  await sl.allReady(); // <-- WAJIB!

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MPDAM App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      routerDelegate: goRouterGetX.routerDelegate,
      routeInformationParser: goRouterGetX.routeInformationParser,
      routeInformationProvider: goRouterGetX.routeInformationProvider,
    );
  }
}
