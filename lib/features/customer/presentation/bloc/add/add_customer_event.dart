import 'package:equatable/equatable.dart';

abstract class AddCustomerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SubmitCustomer extends AddCustomerEvent {
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phone;
  final String address;

  SubmitCustomer({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
  });

  @override
  List<Object?> get props => [firstName, middleName, lastName, email, phone, address];
}
