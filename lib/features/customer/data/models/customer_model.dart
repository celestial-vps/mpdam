// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

List<CustomerModel> customerModelFromJson(String str) => List<CustomerModel>.from(
  json.decode(str).map((x) => CustomerModel.fromJson(x)),
);
List<CustomerModel> listCustomerModelFromJson(List str) =>
    List<CustomerModel>.from(str.map((x) => CustomerModel.fromJson(x)));

String customerModelToJson(List<CustomerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CustomerModel {
  final String oid;
  final String firstName;
  final String middleName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CustomerModel({
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

  CustomerModel copyWith({
    String? oid,
    String? firstName,
    String? middleName,
    String? lastName,
    String? email,  
    String? phoneNumber,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CustomerModel(
    oid: oid ?? this.oid,
    firstName: firstName ?? this.firstName,
    middleName: middleName ?? this.middleName,
    lastName: lastName ?? this.lastName,
    email: email ?? this.email,
    phoneNumber: phoneNumber ?? this.phoneNumber,
    address: address ?? this.address,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    oid: json["oid"],
    firstName: json["firstName"],
    middleName: json["middleName"],
    lastName: json["lastName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],    
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : null, // <-- aman walaupun null
  );

  Map<String, dynamic> toJson() => {
    "oid": oid,
    "firstName": firstName,
    "middleName": middleName,
    "lastName": lastName,
    "email": email,
    "phoneNumber": phoneNumber,
    "address": address,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
