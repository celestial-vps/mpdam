import 'package:mpdam/services/api/api_client.dart';

import '../models/login_response.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService({required this.apiClient});
  Future<LoginResponse> login(String email, String password) async {
    try {
      final response = await apiClient.dio.post(
        '/api/v1/auth/login',
        data: {'email': email, 'password': password},
      );

      print('Status code: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        return LoginResponse.fromJson(response.data);
      } else {
        throw Exception(
          'Login failed with status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Login exception: $e');
      rethrow; // lempar lagi supaya bisa ditangkap di UI
    }
  }

  Future<void> register(String email, String password) async {
    final response = await apiClient.dio.post(
      '/api/v1/auth/register',
      data: {'email': email, 'password': password},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Register success: ${response.data}');
    } else {
      throw Exception('Register failed: ${response.data}');
    }
  }

  Future<void> sendEmail(String email) async {
    try {
      final response = await apiClient.dio.post(
        '/api/v1/misc/send-email',
        data: {'email': email},
      );

      if (response.statusCode == 200) {
        // Email berhasil dikirim, bisa return void atau response.data sesuai kebutuhan
        print('Email sent successfully: ${response.data}');
      } else {
        throw Exception('Failed to send email: ${response.statusCode}');
      }
    } catch (e) {
      print('Send email exception: $e');
      rethrow;
    }
  }
}
