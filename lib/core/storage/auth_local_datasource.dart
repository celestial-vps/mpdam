import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  String? get token;
  Future<bool> persistToken(String token);
  Future<bool> removeToken();

  bool get isLoggedIn => token != null;
  Future<bool> hasToken();
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
  Future<bool> persistToken(String token) =>
      _sharedPreferences.setString(_tokenKey, token);

  @override
  Future<bool> removeToken() =>
      _sharedPreferences.remove(_tokenKey);

  @override
  Future<bool> hasToken() async => _sharedPreferences.containsKey(_tokenKey);
}
