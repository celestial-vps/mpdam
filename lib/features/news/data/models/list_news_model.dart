import 'dart:convert';
import 'package:mpdam/core/models/pagging_model.dart'; 
import 'package:mpdam/features/news/data/models/news_model.dart';
 
ListNewsModel listNewsModelFromJson(String str) => ListNewsModel.fromJson(json.decode(str));

String listNewsModelToJson(ListNewsModel data) => json.encode(data.toJson());

class ListNewsModel {
  final String resultCode;
  final int httpStatus;
  final String message;
  final PaggingModel pagination;
  final List<NewsModel> data;

  ListNewsModel({
    required this.resultCode,
    required this.httpStatus,
    required this.message,
    required this.pagination,
    required this.data,
  });

  ListNewsModel copyWith({
    String? resultCode,
    int? httpStatus,
    String? message,
    PaggingModel? pagination,
    List<NewsModel>? data,
  }) =>
      ListNewsModel(
        resultCode: resultCode ?? this.resultCode,
        httpStatus: httpStatus ?? this.httpStatus,
        message: message ?? this.message,
        pagination: pagination ?? this.pagination,
        data: data ?? this.data,
      );

  factory ListNewsModel.fromJson(Map<String, dynamic> json) => ListNewsModel(
        resultCode: json["resultCode"],
        httpStatus: json["httpStatus"],
        message: json["message"],
        pagination: PaggingModel.fromJson(json["pagination"]),
        data: List<NewsModel>.from(json["data"].map((x) => NewsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCode": resultCode,
        "httpStatus": httpStatus,
        "message": message,
        "pagination": pagination.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
