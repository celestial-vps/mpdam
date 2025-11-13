
import 'package:mpdam/core/network/http_manager.dart';
import 'package:mpdam/features/bank/data/models/list_bank_model.dart';
import 'package:mpdam/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:mpdam/features/customer/data/models/create_customer_model.dart';
import 'package:mpdam/features/customer/data/models/customer_model.dart';
import 'package:mpdam/features/customer/data/models/list_customer_model.dart';
import 'package:mpdam/features/customer/data/models/update_customer_model.dart';

abstract class BankRemoteDataSource {
  Future<ListBankModel> getAllBanks({
    int? pageIndex,
    int? pageSize,
    Map<String, dynamic>? search,
  });
  // Future<BankModel> getBankById(String oid);
  // Future<void> createBank(CreateBankModel data);
  // Future<void> deleteBank(String oid);
  // Future<void> updateBank(String oid, UpdateBankModel data);
}

class CustomerRemoteDataSourceImplementation extends CustomerRemoteDataSource {
  final HttpManager _httpManager;
  CustomerRemoteDataSourceImplementation({required HttpManager httpManager})
    : _httpManager = httpManager;

  @override
  Future<void> createCustomer(CreateCustomerModel data) {
    // TODO: implement createCustomer
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCustomer(String oid) {
    // TODO: implement deleteCustomer
    throw UnimplementedError();
  }

  @override
  Future<ListCustomerModel> getAllCustomers({int? pageIndex, int? pageSize, Map<String, dynamic>? search}) {
    // TODO: implement getAllCustomers
    throw UnimplementedError();
  }

  @override
  Future<CustomerModel> getCustomerById(String oid) {
    // TODO: implement getCustomerById
    throw UnimplementedError();
  }

  @override
  Future<void> updateCustomer(String oid, UpdateCustomerModel data) {
    // TODO: implement updateCustomer
    throw UnimplementedError();
  }
}