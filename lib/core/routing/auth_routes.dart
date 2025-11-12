// lib/core/router/auth_routes.dart
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/login_page.dart';
import '../../features/auth/presentation/register_page.dart';
import '../../features/auth/presentation/forgot_password_page.dart';

final authRoutes = [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/register',
    builder: (context, state) => const RegisterPage(),
  ),
  GoRoute(
    path: '/forgot-password',
    builder: (context, state) => const ForgotPasswordPage(),
  ),
];
