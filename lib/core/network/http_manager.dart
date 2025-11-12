import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:mpdam/core/network/api_constants.dart';

abstract class HttpManager {
  Future<Response> get({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  Future<Response> post({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  });

  Future<Response> patch({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });

  Future<Response> put({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  });

  Future<Response> delete({
    required String url,
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  });
}

class AppHttpManager implements HttpManager {
  final Dio _dio = Dio();
  final String _baseUrl = ApiConstants.baseUrl;

  Duration _httpTimeout = const Duration(seconds: 30);
  Duration _httpUploadTimeout = const Duration(seconds: 90);

  AppHttpManager() {
    _dio.options.baseUrl = _baseUrl;
    // interceptor dihapus sementara
  }

  @override
  Future<Response> get({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio
          .get(
            _queryBuilder(url, query),
            data: body != null ? json.encode(body) : null,
            options: Options(headers: _headerBuilder(headers)),
          )
          .timeout(_httpTimeout, onTimeout: () => throw TimeoutException("Request timeout"));
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> post({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) async {
    try {
      final response = await _dio.post(
        _queryBuilder(url, query),
        data: formData ?? (body != null ? json.encode(body) : null),
        options: Options(headers: _headerBuilder(headers)),
      ).timeout(isUploadImage ? _httpUploadTimeout : _httpTimeout, onTimeout: () => throw TimeoutException("Request timeout"));
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> patch({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.patch(
        _queryBuilder(url, query),
        data: body != null ? json.encode(body) : null,
        options: Options(headers: _headerBuilder(headers)),
      ).timeout(_httpTimeout, onTimeout: () => throw TimeoutException("Request timeout"));
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> put({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
  }) async {
    try {
      final response = await _dio.put(
        _queryBuilder(url, query),
        data: formData ?? (body != null ? json.encode(body) : null),
        options: Options(headers: _headerBuilder(headers)),
      ).timeout(isUploadImage ? _httpUploadTimeout : _httpTimeout, onTimeout: () => throw TimeoutException("Request timeout"));
      return response;
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Response> delete({
    required String url,
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        _queryBuilder(url, query),
        data: body != null ? json.encode(body) : null,
        options: Options(headers: _headerBuilder(headers)),
      ).timeout(_httpTimeout, onTimeout: () => throw TimeoutException("Request timeout"));
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // PRIVATE HELPERS
  Map<String, String> _headerBuilder(Map<String, String>? headers) {
    headers ??= {};
    headers[HttpHeaders.acceptHeader] = 'application/json';
    headers[HttpHeaders.contentTypeHeader] ??= 'application/json';
    return headers;
  }

  String _queryBuilder(String path, Map<String, dynamic>? query) {
    final buffer = StringBuffer();
    buffer.write(_baseUrl + path);
    if (query != null && query.isNotEmpty) {
      buffer.write('?');
      query.forEach((key, value) {
        buffer.write('$key=$value&');
      });
    }
    return buffer.toString();
  }
}
