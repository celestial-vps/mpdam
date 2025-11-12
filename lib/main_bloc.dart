// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initDependencies();
//   await sl.allReady();
//   runApp(MyAppBloc());
// }

// class MyAppBloc extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (_) => sl<CustomerBloc>()..add(LoadCustomers())),
//       ],
//       child: MaterialApp(
//         title: 'App - BLoC',
//         initialRoute: '/home',
//         routes: {
//           '/home': (_) => HomePage(),
//           '/customers': (_) => CustomerPage(),
//         },
//       ),
//     );
//   }
// }
