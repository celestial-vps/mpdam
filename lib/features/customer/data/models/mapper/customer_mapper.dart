
import 'package:mpdam/features/customer/data/models/customer_model.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';

extension CustomerMapper on List<CustomerModel> {
  List<Customer> toDomain() => List.from(
        map(
          (e) => e.toDomain(),
        ),
      );
}

extension CustomerModelMapper on CustomerModel {
  Customer toDomain() => Customer(
        oid: oid,
        middleName: middleName,
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        address: address,
        createdAt: createdAt,
        updatedAt: updatedAt,
        
      );
}
