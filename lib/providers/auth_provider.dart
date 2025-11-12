import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/auth_service.dart';
import 'auth_service_provider.dart';

final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService)..checkLogin();
});

class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;

  AuthNotifier(this._authService) : super(false);

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    state = token != null;
  }

  Future<void> login(String email, String password) async {
    final result = await _authService.login(email, password);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', result.token);
    state = true;
  }

  // ✅ Tambahkan method ini:
  Future<void> register(String email, String password) async {
    await _authService.register(email, password);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    state = false;
  }
}
