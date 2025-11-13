import 'package:equatable/equatable.dart';
import 'package:mpdam/core/entity/pagging_entity.dart';

class CustomerEntity extends Equatable {
  final PaggingEntity pagination;
  final List<Customer> data;

  const CustomerEntity({required this.pagination, required this.data});

  @override
  List<Object?> get props => [pagination, data];
}

class Customer extends Equatable {
  final String oid;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Customer({
    required this.oid,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  List<Object?> get props => [
    oid,
    firstName,
    middleName,
    lastName,
    email,
    phoneNumber,
    address,
    createdAt,
    updatedAt, // bisa null
  ];
  // @override
  // List<Object> get props {
  //   return [
  //     oid,
  //     firstName,
  //     middleName,
  //     createdAt,
  //     updatedAt,
  //   ];
  // }
}
