// To parse this JSON data, do
//
//     final createCustomerModel = createCustomerModelFromJson(jsonString);

import 'dart:convert';

UpdateCustomerModel createCustomerModelFromJson(String str) => UpdateCustomerModel.fromJson(json.decode(str));

String createCustomerModelToJson(UpdateCustomerModel data) => json.encode(data.toJson());

class UpdateCustomerModel {
  final String firstName;
  final String middleName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String email;

  UpdateCustomerModel({
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.phoneNumber,
    required this.address,
    required this.email,
  });

  UpdateCustomerModel copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? phoneNumber,
    String? address,
    String? email,
  }) =>
      UpdateCustomerModel(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        address: address ?? this.address,
        email: email ?? this.email,
      );

  factory UpdateCustomerModel.fromJson(Map<String, dynamic> json) => UpdateCustomerModel(
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
