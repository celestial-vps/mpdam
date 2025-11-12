// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initDependencies();
//   await sl.allReady();
//   runApp(const ProviderScope(child: MyAppRiverpod()));
// }

// class MyAppRiverpod extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final router = ref.watch(routerProvider);
//     return MaterialApp.router(
//       title: 'App - Riverpod',
//       routerConfig: router,
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
