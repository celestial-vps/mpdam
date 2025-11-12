import 'package:mpdam/core/network/api_constants.dart';
import 'package:mpdam/core/network/http_manager.dart';
import 'package:mpdam/features/customer/data/models/create_customer_model.dart';
import 'package:mpdam/features/customer/data/models/customer_model.dart';
import 'package:mpdam/features/customer/data/models/list_customer_model.dart';
import 'package:mpdam/features/customer/data/models/update_customer_model.dart';
import 'dart:convert';

abstract class CustomerRemoteDataSource {
  Future<ListCustomerModel> getAllCustomers({
    int? pageIndex,
    int? pageSize,
    Map<String, dynamic>? search,
  });
  Future<CustomerModel> getCustomerById(String oid);
  Future<void> createCustomer(CreateCustomerModel data);
  Future<void> deleteCustomer(String oid);
  Future<void> updateCustomer(String oid, UpdateCustomerModel data);
}

class CustomerRemoteDataSourceImplementation extends CustomerRemoteDataSource {
  final HttpManager _httpManager;
  CustomerRemoteDataSourceImplementation({required HttpManager httpManager})
    : _httpManager = httpManager;

  @override
  Future<ListCustomerModel> getAllCustomers({
    int? pageIndex,
    int? pageSize,
    Map<String, dynamic>? search,
  }) async {
    try {
      // --- Build query parameters ---
      final Map<String, dynamic> query = {};
      if (pageIndex != null && pageSize != null) {
        query['pageIndex'] = pageIndex;
        query['pageSize'] = pageSize;
      }

      // --- Build body ---
      final Map<String, dynamic> body = {};
      // --- Log body sebelum request ---
      print('=== BODY TO search ===');
      print(jsonEncode(search));
      if (search != null && search.isNotEmpty) {
        body.addAll(search); // merge semua key-value dari map search
      }
      // if (search != null && search.isNotEmpty) {
      //   body['search'] = search;
      // }

      // --- Log body sebelum request ---
      print('=== BODY TO SEND ===');
      print(jsonEncode(body.isNotEmpty ? body : {}));

      // --- Build cURL command for debug ---
      final uri = Uri.parse("${ApiConstants.customerRoot}/q").replace(
        queryParameters: query.map((k, v) => MapEntry(k, v.toString())),
      );

      final curlBuffer = StringBuffer();
      curlBuffer.write('curl -X POST "${uri.toString()}"');
      curlBuffer.write(
        ' -H "Authorization: Bearer ${ApiConstants.staticToken}"',
      );
      curlBuffer.write(' -H "Content-Type: application/json"');
      if (body.isNotEmpty) {
        final String curlBody = jsonEncode(body);
        curlBuffer.write(" -d '${curlBody.replaceAll("'", "\\'")}'");
      }
      print('=== cURL ===');
      print(curlBuffer.toString());

      // --- Send request ---
      final response = await _httpManager.post(
        url: "${ApiConstants.customerRoot}/q",
        query: query,
        body: body.isNotEmpty
            ? body
            : {}, // KIRIM body kosong sebagai {} kalau tidak ada search
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
      );

      // --- Log response ---
      print('=== API RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Data: ${response.data}');

      return ListCustomerModel.fromJson(response.data);
    } catch (e, stackTrace) {
      print('=== API ERROR ===');
      print(e);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> createCustomer(CreateCustomerModel data) async {
    try {
      await _httpManager.post(
        url: '${ApiConstants.customerRoot}/create',
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
        body: data.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteCustomer(String oid) async {
    try {
      final response = await _httpManager.delete(
        url: "${ApiConstants.customerRoot}/delete/$oid",
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
      );
      print('=== API RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Data: ${response.data}');
      // final customerModel = ListCustomerModel.fromJson(response.data);
      // return customerModel;
    } catch (e, stackTrace) {
      print('=== API ERROR ===');
      print(e);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<CustomerModel> getCustomerById(String oid) async {
    try {
      //
      final response = await _httpManager.get(
        url: "${ApiConstants.customerRoot}/$oid",
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
      );
      final customerModel = CustomerModel.fromJson(response.data['data']);

      return customerModel;
    } catch (e) {
      //
      rethrow;
    }
  }

  @override
  Future<void> updateCustomer(String oid, UpdateCustomerModel data) async {
    try {
      await _httpManager.put(
        url: "${ApiConstants.customerRoot}/$oid",
        headers: {'Authorization': 'Bearer ${ApiConstants.staticToken}'},
        body: data.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
