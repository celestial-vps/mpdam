import 'package:mpdam/core/network/api_constants.dart';
import 'package:mpdam/core/network/http_manager.dart';
import 'package:mpdam/core/storage/auth_local_datasource.dart';
import 'package:mpdam/features/bank/data/dtos/create_bank_dto.dart';
import 'package:mpdam/features/bank/data/dtos/filter_bank_dto.dart';
import 'package:mpdam/features/bank/data/dtos/update_bank_dto.dart';
import 'package:mpdam/features/bank/data/models/bank_model.dart';
import 'package:mpdam/features/bank/data/models/list_bank_model.dart';
import 'package:dio/dio.dart';

abstract class BankRemoteDataSource {
  Future<ListBankModel> getAllBanks({
    int? pageIndex,
    int? pageSize,
    FilterBankDto? filterBankDto,
  });

  Future<BankModel> getBankById(String oid);
  Future<void> createBank(CreateBankDto data);
  Future<void> updateBank(String oid, UpdateBankDto data);
  Future<void> deleteBank(String oid);
}

class BankRemoteDataSourceImplementation extends BankRemoteDataSource {
  final HttpManager _httpManager;
  final AuthLocalDataSource _authLocal;
  final String baseUrl;
  final bool enableLogging;

  BankRemoteDataSourceImplementation({
    required HttpManager httpManager,
    required AuthLocalDataSource authLocal,
    this.baseUrl = ApiConstants.baseUrl,
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
  Future<ListBankModel> getAllBanks({
    int? pageIndex,
    int? pageSize,
    FilterBankDto? filterBankDto,
  }) async {
    try {
      final query = <String, dynamic>{};
      if (pageIndex != null) query['pageIndex'] = pageIndex;
      if (pageSize != null) query['pageSize'] = pageSize;

      final body = filterBankDto?.toJson() ?? {};

      _log('QUERY PARAMETERS', query);
      _log('REQUEST BODY', body);
      _log('HEADERS SENT', _defaultHeaders());

      final response = await _httpManager.post(
        url: "${ApiConstants.bankRoot}/q",
        query: query,
        body: body,
        headers: _defaultHeaders(),
        baseUrl: baseUrl,
      );

      _log('API RESPONSE', response.data);

      return ListBankModel.fromJson(response.data);
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    }
  }

  @override
  Future<BankModel> getBankById(String oid) async {
    try {
      _log('HEADERS SENT', _defaultHeaders());

      final response = await _httpManager.get(
        url: "${ApiConstants.bankRoot}/$oid",
        headers: _defaultHeaders(),
        baseUrl: baseUrl,
      );

      _log('API RESPONSE GET BANK', response.data);

      return BankModel.fromJson(response.data["data"]);
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    }
  }

  @override
  Future<void> createBank(CreateBankDto data) async {
    try {
      _log('HEADERS SENT', _defaultHeaders());

      await _httpManager.post(
        url: "${ApiConstants.bankRoot}/create",
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
  Future<void> updateBank(String oid, UpdateBankDto data) async {
    try {
      _log('HEADERS SENT', _defaultHeaders());

      final response = await _httpManager.put(
        url: "${ApiConstants.bankRoot}/$oid",
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
  Future<void> deleteBank(String oid) async {
    try {
      _log('HEADERS SENT', _defaultHeaders());

      await _httpManager.delete(
        url: "${ApiConstants.bankRoot}/delete/$oid",
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
