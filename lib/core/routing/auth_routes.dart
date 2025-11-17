// lib/core/router/auth_routes.dart
import 'package:go_router/go_router.dart';
import 'package:mpdam/features/auth/presentation/bindings/auth_binding.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';

final authRoutes = [
  GoRoute(
    path: '/login',
    builder: (context, state) {
      AuthBinding.init();
      return LoginPage();
    },
  ),
  GoRoute(path: '/register', builder: (context, state) => const RegisterPage()),
  GoRoute(
    path: '/forgot-password',
    builder: (context, state) => const ForgotPasswordPage(),
  ),
];
