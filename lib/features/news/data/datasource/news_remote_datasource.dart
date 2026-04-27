import 'package:mpdam/core/network/api_constants.dart';
import 'package:mpdam/core/network/http_manager.dart';
import 'package:mpdam/core/storage/auth_local_datasource.dart';
import 'package:mpdam/features/news/data/dtos/create_news_dto.dart';
import 'package:mpdam/features/news/data/dtos/filter_news_dto.dart';
import 'package:mpdam/features/news/data/dtos/update_news_dto.dart';
import 'package:mpdam/features/news/data/models/news_model.dart';
import 'package:mpdam/features/news/data/models/list_news_model.dart';
import 'package:dio/dio.dart';

abstract class NewsRemoteDataSource {
  Future<ListNewsModel> getAllNewss({
    int? pageIndex,
    int? pageSize,
    FilterNewsDto? filterNewsDto,
  });

  Future<NewsModel> getNewsById(String oid);
  Future<void> createNews(CreateNewsDto data);
  Future<void> updateNews(String oid, UpdateNewsDto data);
  Future<void> deleteNews(String oid);
}

class NewsRemoteDataSourceImplementation extends NewsRemoteDataSource {
  final HttpManager _httpManager;
  final AuthLocalDataSource _authLocal;
  final String baseUrl;
  final bool enableLogging;

  NewsRemoteDataSourceImplementation({
    required HttpManager httpManager,
    required AuthLocalDataSource authLocal,
    this.baseUrl = ApiConstants.newsUrl,
    this.enableLogging = true,
  })  : _httpManager = httpManager,
        _authLocal = authLocal;

  // FIXED — header aman & valid
  Map<String, String> _defaultHeaders() {
    final token = _authLocal.token?.trim();

    return {
      "Content-Type": "application/json",
      if (token != null && token.isNotEmpty) "Authorization": "Bearer $token",
    };
  }

  void _log(String title, dynamic value) {
    if (enableLogging) {
      print('=== $title ===');
      print(value);
    }
  }

  @override
  Future<ListNewsModel> getAllNewss({
    int? pageIndex,
    int? pageSize,
    FilterNewsDto? filterNewsDto,
  }) async {
    try {
      final query = <String, dynamic>{};
      if (pageIndex != null) query['pageIndex'] = pageIndex;
      if (pageSize != null) query['pageSize'] = pageSize;

      final body = filterNewsDto?.toJson() ?? {};

      _log('QUERY PARAMETERS', query);
      _log('REQUEST BODY', body);
      _log('HEADERS SENT', _defaultHeaders());

      final response = await _httpManager.post(
        url: "${ApiConstants.newsRoot}/q",
        query: query,
        body: body,
        headers: _defaultHeaders(),
        baseUrl: baseUrl,
      );

      _log('API RESPONSE', response.data);

      return ListNewsModel.fromJson(response.data);
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    }
  }

  @override
  Future<NewsModel> getNewsById(String oid) async {
    try {
      _log('HEADERS SENT', _defaultHeaders());

      final response = await _httpManager.get(
        url: "${ApiConstants.newsRoot}/$oid",
        headers: _defaultHeaders(),
        baseUrl: baseUrl,
      );

      _log('API RESPONSE GET BANK', response.data);

      return NewsModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    }
  }

  @override
  Future<void> createNews(CreateNewsDto data) async {
    try {
      _log('HEADERS SENT', _defaultHeaders());

      await _httpManager.post(
        url: "${ApiConstants.newsRoot}/create",
        headers: _defaultHeaders(),
        body: data.toJson(),
        baseUrl: baseUrl,
      );

      _log('CREATE BANK', 'Success');
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    }
  }

  @override
  Future<void> updateNews(String oid, UpdateNewsDto data) async {
    try {
      _log('HEADERS SENT', _defaultHeaders());

      final response = await _httpManager.put(
        url: "${ApiConstants.newsRoot}/$oid",
        headers: _defaultHeaders(),
        body: data.toJson(),
        baseUrl: baseUrl,
      );

      _log('UPDATE BANK RESPONSE', response.data);
      _log('UPDATE BANK', 'Success');
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    }
  }

  @override
  Future<void> deleteNews(String oid) async {
    try {
      _log('HEADERS SENT', _defaultHeaders());

      await _httpManager.delete(
        url: "${ApiConstants.newsRoot}/delete/$oid",
        headers: _defaultHeaders(),
        baseUrl: baseUrl,
      );

      _log('DELETE BANK', 'Success');
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    }
  }
}
