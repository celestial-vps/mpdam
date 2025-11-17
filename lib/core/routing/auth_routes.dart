import 'package:go_router/go_router.dart';
import 'package:mpdam/features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';

final loginController = Get.find<LoginController>();

final List<GoRoute> authRoutes = [
  GoRoute(
    path: '/login',
    builder: (context, state) => LoginPage(controller: loginController),
  ),
  // misal register route
  GoRoute(
    path: '/register',
    builder: (context, state) => RegisterPage(),
  ),
];
