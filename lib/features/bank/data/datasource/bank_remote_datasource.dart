import 'package:mpdam/core/network/api_constants.dart';
import 'package:mpdam/core/network/http_manager.dart';
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
  final String baseUrl; // simpan baseUrl di sini
  final bool enableLogging;

  BankRemoteDataSourceImplementation({
    required HttpManager httpManager,
    this.baseUrl = ApiConstants.baseUrl, // default bisa diganti
    this.enableLogging = true,
  }) : _httpManager = httpManager;

  Map<String, String> _defaultHeaders() => {
    'Authorization': 'Bearer ${ApiConstants.staticToken}',
    'Content-Type': 'application/json',
  };

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
    } catch (e, st) {
      _log('UNKNOWN ERROR', e);
      _log('STACKTRACE', st);
      rethrow;
    }
  }

  @override
  Future<BankModel> getBankById(String oid) async {
    try {
      final response = await _httpManager.get(
        url: "${ApiConstants.bankRoot}/$oid",
        headers: _defaultHeaders(),
        baseUrl: baseUrl,
      );

      _log('API RESPONSE GET BANK', response.data);

      return BankModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    } catch (e, st) {
      _log('UNKNOWN ERROR', e);
      _log('STACKTRACE', st);
      rethrow;
    }
  }

  @override
  Future<void> createBank(CreateBankDto data) async {
    try {
      await _httpManager.post(
        url: '${ApiConstants.bankRoot}/create',
        headers: _defaultHeaders(),
        body: data.toJson(),
        baseUrl: baseUrl,
      );
      _log('CREATE BANK', 'Success');
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    } catch (e, st) {
      _log('UNKNOWN ERROR', e);
      _log('STACKTRACE', st);
      rethrow;
    }
  }

  @override
  Future<void> updateBank(String oid, UpdateBankDto data) async {
    try {
      final response= await _httpManager.put(
        url: "${ApiConstants.bankRoot}/$oid",
        headers: _defaultHeaders(),
        body: data.toJson(),
        baseUrl: baseUrl,
      );
      _log('UPDATE BANK RESPONSE', response);
      _log('UPDATE BANK', 'Success');
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    } catch (e, st) {
      _log('UNKNOWN ERROR', e);
      _log('STACKTRACE', st);
      rethrow;
    }
  }

  @override
  Future<void> deleteBank(String oid) async {
    try {
      await _httpManager.delete(
        url: "${ApiConstants.bankRoot}/delete/$oid",
        headers: _defaultHeaders(),
        baseUrl: baseUrl,
      );
      _log('DELETE BANK', 'Success');
    } on DioException catch (e) {
      _log('DIO ERROR', e.response?.data ?? e.message);
      rethrow;
    } catch (e, st) {
      _log('UNKNOWN ERROR', e);
      _log('STACKTRACE', st);
      rethrow;
    }
  }
}
