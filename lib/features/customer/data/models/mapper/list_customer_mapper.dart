import 'package:mpdam/core/models/mapper/pagging_mapper.dart';
import 'package:mpdam/features/customer/data/models/list_customer_model.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';
import 'package:mpdam/features/customer/data/models/mapper/customer_mapper.dart';

extension ListCustomerMapper on ListCustomerModel {
  CustomerEntity toDomain() => CustomerEntity(
        pagination: pagination.toDomain(),
        data: data.toDomain(),
      );
}
