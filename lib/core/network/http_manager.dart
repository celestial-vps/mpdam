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
    String? baseUrl,
  });

  Future<Response> post({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
    String? baseUrl,
  });

  Future<Response> patch({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? baseUrl,
  });

  Future<Response> put({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
    String? baseUrl,
  });

  Future<Response> delete({
    required String url,
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? baseUrl,
  });
}

class AppHttpManager implements HttpManager {
  final Dio _dio = Dio();
  final Duration _httpTimeout = const Duration(seconds: 30);
  final Duration _httpUploadTimeout = const Duration(seconds: 90);

  AppHttpManager() {
    // default interceptor atau config bisa ditambahkan di sini
  }

  // ----------------------- GET -----------------------
  @override
  Future<Response> get({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio
          .get(
            _buildUrl(url, query, baseUrl),
            data: body != null ? json.encode(body) : null,
            options: Options(headers: _buildHeaders(headers)),
          )
          .timeout(
            _httpTimeout,
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // ----------------------- POST -----------------------
  @override
  Future<Response> post({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio
          .post(
            _buildUrl(url, query, baseUrl),
            data: formData ?? (body != null ? json.encode(body) : null),
            options: Options(headers: _buildHeaders(headers)),
          )
          .timeout(
            isUploadImage ? _httpUploadTimeout : _httpTimeout,
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // ----------------------- PATCH -----------------------
  @override
  Future<Response> patch({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio
          .patch(
            _buildUrl(url, query, baseUrl),
            data: body != null ? json.encode(body) : null,
            options: Options(headers: _buildHeaders(headers)),
          )
          .timeout(
            _httpTimeout,
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // ----------------------- PUT -----------------------
  @override
  Future<Response> put({
    required String url,
    Map? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    FormData? formData,
    bool isUploadImage = false,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio
          .put(
            _buildUrl(url, query, baseUrl),
            data: formData ?? (body != null ? json.encode(body) : null),
            options: Options(headers: _buildHeaders(headers)),
          )
          .timeout(
            isUploadImage ? _httpUploadTimeout : _httpTimeout,
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // ----------------------- DELETE -----------------------
  @override
  Future<Response> delete({
    required String url,
    Object? body,
    Map<String, dynamic>? query,
    Map<String, String>? headers,
    String? baseUrl,
  }) async {
    try {
      final response = await _dio
          .delete(
            _buildUrl(url, query, baseUrl),
            data: body != null ? json.encode(body) : null,
            options: Options(headers: _buildHeaders(headers)),
          )
          .timeout(
            _httpTimeout,
            onTimeout: () => throw TimeoutException("Request timeout"),
          );
      return response;
    } catch (error) {
      rethrow;
    }
  }

  // ----------------------- PRIVATE HELPERS -----------------------
  Map<String, String> _buildHeaders(Map<String, String>? headers) {
    final finalHeaders = <String, String>{
      HttpHeaders.acceptHeader: 'application/json',
      ...?headers, // menimpa accept jika sudah ada
    };
    return finalHeaders;
  }

  String _buildUrl(String path, Map<String, dynamic>? query, String? baseUrl) {
    final finalBaseUrl = baseUrl ?? ApiConstants.baseUrl;
    final uri = Uri.parse(finalBaseUrl + path);
    if (query == null || query.isEmpty) return uri.toString();
    final newUri = uri.replace(
      queryParameters: query.map((k, v) => MapEntry(k, v.toString())),
    );
    return newUri.toString();
  }
}
