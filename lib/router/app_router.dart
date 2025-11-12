// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mpdam/features/auth/presentation/forgot_password_page.dart';
// import 'package:mpdam/features/auth/presentation/register_page.dart';
// import '../features/auth/presentation/login_page.dart';
// import '../features/home/presentation/home_page.dart';
// import '../providers/auth_provider.dart';
// import '../core/utils/go_router_refresh_stream.dart';

// final routerProvider = Provider<GoRouter>((ref) {
//   final isLoggedIn = ref.watch(authProvider);
//   final notifier = ref.read(authProvider.notifier);

//   return GoRouter(
//     initialLocation: '/login',
//     refreshListenable: GoRouterRefreshStream(notifier.stream),
//     redirect: (context, state) {
//       final isGoingToLogin = state.uri.toString() == '/login';
//       final isGoingToRegister = state.uri.toString() == '/register';
//       final isGoingToForgotPassword =
//           state.uri.toString() == '/forgot-password';

//       // Jika belum login, hanya boleh ke login, register, atau forgot-password
//       if (!isLoggedIn &&
//           !(isGoingToLogin || isGoingToRegister || isGoingToForgotPassword)) {
//         return '/login';
//       }

//       // Jika sudah login dan coba ke login/register, redirect ke home
//       if (isLoggedIn &&
//           (isGoingToLogin || isGoingToRegister || isGoingToForgotPassword)) {
//         return '/home';
//       }

//       return null;
//     },

//     routes: [
//       GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
//       GoRoute(path: '/home', builder: (context, state) => const HomePage()),
//       GoRoute(
//         path: '/register',
//         builder: (context, state) => const RegisterPage(),
//       ),
//       GoRoute(
//         path: '/forgot-password',
//         builder: (context, state) => const ForgotPasswordPage(),
//       ),
//     ],
//   );
// });
