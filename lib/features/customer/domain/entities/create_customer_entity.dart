import 'package:equatable/equatable.dart';

class CreateCustomerEntity extends Equatable {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String email;

  const CreateCustomerEntity({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.email,
  });
  @override
  List<Object?> get props => [
        firstName,
        middleName,
        lastName,
        phoneNumber,
        address,
        email,
      ];
}
