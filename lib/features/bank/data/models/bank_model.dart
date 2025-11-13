// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

List<BankModel> customerModelFromJson(String str) => List<BankModel>.from(
  json.decode(str).map((x) => BankModel.fromJson(x)),
);
List<BankModel> listBankModelFromJson(List str) =>
    List<BankModel>.from(str.map((x) => BankModel.fromJson(x)));

String customerModelToJson(List<BankModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankModel {
  final String oid;
  final String bankCode;
  final String bankName;
  // final String shortName;
  final DateTime createdAt;
  final DateTime? updatedAt;

  BankModel({
    required this.oid,
    required this.bankCode,
    required this.bankName,
    // required this.shortName,    
    required this.createdAt,
    required this.updatedAt,
  });

  BankModel copyWith({
    String? oid,
    String? bankCode,
    String? bankName,
    // String? shortName,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BankModel(
    oid: oid ?? this.oid,
    bankCode: bankCode ?? this.bankCode,
    bankName: bankName ?? this.bankName,
    // shortName: shortName ?? this.shortName,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
    oid: json["oid"],
    bankCode: json["bankCode"],
    bankName: json["bankName"],
    // shortName: json["shortName"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : null, // <-- aman walaupun null
  );

  Map<String, dynamic> toJson() => {
    "oid": oid,
    "bankCode": bankCode,
    "bankName": bankName,
    // "shortName": shortName,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
