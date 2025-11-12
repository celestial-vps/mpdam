// To parse this JSON data, do
//
//     final listCustomerModel = listCustomerModelFromJson(jsonString);

import 'dart:convert';

import 'package:mpdam/core/models/pagging_model.dart';
import 'package:mpdam/features/customer/data/models/customer_model.dart';
 
ListCustomerModel listCustomerModelFromJson(String str) => ListCustomerModel.fromJson(json.decode(str));

String listCustomerModelToJson(ListCustomerModel data) => json.encode(data.toJson());

class ListCustomerModel {
  final String resultCode;
  final String httpStatus;
  final String developerMessage;
  final PaggingModel pagging;
  final List<CustomerModel> data;

  ListCustomerModel({
    required this.resultCode,
    required this.httpStatus,
    required this.developerMessage,
    required this.pagging,
    required this.data,
  });

  ListCustomerModel copyWith({
    String? resultCode,
    String? httpStatus,
    String? developerMessage,
    PaggingModel? pagging,
    List<CustomerModel>? data,
  }) =>
      ListCustomerModel(
        resultCode: resultCode ?? this.resultCode,
        httpStatus: httpStatus ?? this.httpStatus,
        developerMessage: developerMessage ?? this.developerMessage,
        pagging: pagging ?? this.pagging,
        data: data ?? this.data,
      );

  factory ListCustomerModel.fromJson(Map<String, dynamic> json) => ListCustomerModel(
        resultCode: json["resultCode"],
        httpStatus: json["http_status"],
        developerMessage: json["developerMessage"],
        pagging: PaggingModel.fromJson(json["pagging"]),
        data: List<CustomerModel>.from(json["data"].map((x) => CustomerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "http_status": httpStatus,
        "developerMessage": developerMessage,
        "pagging": pagging.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
