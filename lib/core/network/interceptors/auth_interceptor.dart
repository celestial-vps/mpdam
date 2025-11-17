import 'package:dio/dio.dart';
import 'package:mpdam/core/storage/auth_local_datasource.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource localDataSource;

  AuthInterceptor(this.localDataSource);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = localDataSource.token;

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    return handler.next(options);
  }
}
