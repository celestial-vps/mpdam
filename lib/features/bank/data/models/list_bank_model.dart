import 'dart:convert';
import 'package:mpdam/core/models/pagging_model.dart';
import 'package:mpdam/features/bank/data/models/bank_model.dart';
 
ListBankModel listBankModelFromJson(String str) => ListBankModel.fromJson(json.decode(str));

String listBankModelToJson(ListBankModel data) => json.encode(data.toJson());

class ListBankModel {
  final String resultCode;
  final int httpStatus;
  final String message;
  final PaggingModel pagination;
  final List<BankModel> data;

  ListBankModel({
    required this.resultCode,
    required this.httpStatus,
    required this.message,
    required this.pagination,
    required this.data,
  });

  ListBankModel copyWith({
    String? resultCode,
    int? httpStatus,
    String? message,
    PaggingModel? pagination,
    List<BankModel>? data,
  }) =>
      ListBankModel(
        resultCode: resultCode ?? this.resultCode,
        httpStatus: httpStatus ?? this.httpStatus,
        message: message ?? this.message,
        pagination: pagination ?? this.pagination,
        data: data ?? this.data,
      );

  factory ListBankModel.fromJson(Map<String, dynamic> json) => ListBankModel(
        resultCode: json["resultCode"],
        httpStatus: json["httpStatus"],
        message: json["message"],
        pagination: PaggingModel.fromJson(json["pagination"]),
        data: List<BankModel>.from(json["data"].map((x) => BankModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "httpStatus": httpStatus,
        "message": message,
        "pagination": pagination.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
