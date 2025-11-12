 
import 'dart:convert';

CreateCustomerModel createCustomerModelFromJson(String str) => CreateCustomerModel.fromJson(json.decode(str));

String createCustomerModelToJson(CreateCustomerModel data) => json.encode(data.toJson());

class CreateCustomerModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String email;

  CreateCustomerModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.email,
  });

  CreateCustomerModel copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? email,
  }) =>
      CreateCustomerModel(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        email: email ?? this.email,
      );

  factory CreateCustomerModel.fromJson(Map<String, dynamic> json) => CreateCustomerModel(
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        address: json["address"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "address": address,
        "email": email, 
      };
}
