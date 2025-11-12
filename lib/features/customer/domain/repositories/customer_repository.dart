 
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/customer/domain/entities/create_customer_entity.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mpdam/features/customer/domain/entities/update_customer_entity.dart';

abstract class CustomerRepository {
  Future<Either<Failure, CustomerEntity>> getAllCustomerPagging(PaggingParam paggingParam);
  // Future<Either<Failure, CustomerEntity>> searchCustomers(PaggingParam paggingParam);
  // Future<Either<Failure, CustomerEntity>> getAllCustomer(PaggingParam paggingParam);
  Future<Either<Failure, Customer>> getCustomerById(String oid);
  Future<Either<Failure, Unit>> deleteCustomer(String oid);
  Future<Either<Failure, Unit>> createCustomer(CreateCustomerEntity data);
  Future<Either<Failure, Unit>> updateCustomer(UpdateCustomerEntity data);
}
