import 'package:dio/dio.dart';
import 'package:mpdam/core/network/api_constants.dart';
import 'package:mpdam/core/network/http_manager.dart';
import 'package:mpdam/features/auth/data/dtos/login_dto.dart';
import 'package:mpdam/features/auth/data/dtos/register_dto.dart';
import 'package:mpdam/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(LoginDto data);
  Future<UserModel> register(RegisterDto data);
}

class AuthRemoteDataSourceImplementation extends AuthRemoteDataSource {
  final HttpManager _httpManager;
  final String baseUrl;
  final bool enableLogging;

  AuthRemoteDataSourceImplementation({
    required HttpManager httpManager,
    this.baseUrl = ApiConstants.baseUrl,
    this.enableLogging = true,
  }) : _httpManager = httpManager;

  @override
  Future<UserModel> login(LoginDto data) async {
    final Response response = await _httpManager.post(
      url: ApiConstants.login,
      baseUrl: baseUrl,
      body: data.toJson(),
    );
    return UserModel.fromJson(response.data);
  }

  @override
  Future<UserModel> register(RegisterDto data) async {
    final Response response = await _httpManager.post(
      url: ApiConstants.register,
      baseUrl: baseUrl,
      body: data.toJson(),
    );
    return UserModel.fromJson(response.data);
  }
}
