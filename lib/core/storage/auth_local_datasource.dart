import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  String? get token;
  Future<bool> persistToken(String token);
  Future<bool> removeToken();
}

class AuthLocalDataSourceImplementation extends AuthLocalDataSource {
  static const String _tokenKey = 'token';
  final SharedPreferences _sharedPreferences;

  AuthLocalDataSourceImplementation({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  @override
  String? get token => _sharedPreferences.getString(_tokenKey);

  @override
  Future<bool> persistToken(String token) {
    return _sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<bool> removeToken() {
    return _sharedPreferences.remove(_tokenKey);
  }
}
