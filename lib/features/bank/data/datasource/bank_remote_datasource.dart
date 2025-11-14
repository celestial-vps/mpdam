import 'package:mpdam/core/network/api_constants.dart';
import 'package:mpdam/core/network/http_manager.dart';
import 'package:mpdam/features/bank/data/dtos/create_bank_dto.dart';
import 'package:mpdam/features/bank/data/dtos/filter_bank_dto.dart';
import 'package:mpdam/features/bank/data/models/bank_model.dart';
import 'package:mpdam/features/bank/data/models/list_bank_model.dart';
import 'package:mpdam/features/bank/data/dtos/update_bank_dto.dart';

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
  BankRemoteDataSourceImplementation({required HttpManager httpManager})
    : _httpManager = httpManager;

  @override
  Future<ListBankModel> getAllBanks({
    int? pageIndex,
    int? pageSize,
    FilterBankDto? filterBankDto,
  }) async {
    try {
      // --- Build query parameters ---
      final Map<String, dynamic> query = {};
      if (pageIndex != null) query['pageIndex'] = pageIndex;
      if (pageSize != null) query['pageSize'] = pageSize;

      // --- Build body ---
      final Map<String, dynamic> body = (filterBankDto != null)
          ? filterBankDto.toJson()
          : {};

      // --- Optional logging ---
      print('=== QUERY PARAMETERS ===');
      print(query);
      print('=== BODY ===');
      print(body);

      // --- Send request ---
      final response = await _httpManager.post(
        url: "${ApiConstants.bankRoot}/q", // pastikan endpoint benar
        query: query,
        body: body,
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
      );
      // --- Log response ---
      print('=== API RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Data: ${response.data}');

      // --- Return mapped model ---
      return ListBankModel.fromJson(response.data);
    } catch (e, stackTrace) {
      print('=== BANK API ERROR ===');
      print(e);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<BankModel> getBankById(String oid) async {
    try {
      //
      final response = await _httpManager.get(
        url: "${ApiConstants.bankRoot}/$oid",
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
      );
      final bankModel = BankModel.fromJson(response.data['data']);

      return bankModel;
    } catch (e) {
      //
      rethrow;
    }
  }

  @override
  Future<void> createBank(CreateBankDto data) async {
    try {
      await _httpManager.post(
        url: '${ApiConstants.bankRoot}/create',
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
        body: data.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateBank(String oid, UpdateBankDto data) async {
    try {
      await _httpManager.put(
        url: "${ApiConstants.bankRoot}/$oid",
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
        body: data.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteBank(String oid) async {
    try {
      final response = await _httpManager.delete(
        url: "${ApiConstants.bankRoot}/delete/$oid",
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
      );
    } catch (e, stackTrace) {
      rethrow;
    }
  }
}
