// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

import 'package:mpdam/core/models/image_model.dart';

List<NewsModel> customerModelFromJson(String str) =>
    List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));
List<NewsModel> listNewsModelFromJson(List str) =>
    List<NewsModel>.from(str.map((x) => NewsModel.fromJson(x)));

String customerModelToJson(List<NewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  final String oid;
  final String author;
  final String category;
  final String content;
  final ImageModel? image;
  final String language;
  final String publishedAt;
  final String status;
  final String summary;
  final String title;
  final String tags;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NewsModel({
    required this.oid,
    required this.author,
    required this.category,
    required this.content,
    required this.image,
    required this.language,
    required this.publishedAt,
    required this.status,
    required this.summary,
    required this.title,
    required this.tags,
    required this.createdAt,
    required this.updatedAt,
  });

  NewsModel copyWith({
    String? oid,
    String? author,
    String? category,
    String? content,
    ImageModel? image,
    String? language,
    String? publishedAt,
    String? status,
    String? summary,
    String? title,
    String? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => NewsModel(
    oid: oid ?? this.oid,
    author: author ?? this.author,
    category: category ?? this.category,
    content: content ?? this.content,
    image: image ?? this.image,
    language: language ?? this.language,
    publishedAt: publishedAt ?? this.publishedAt,
    status: status ?? this.status,
    summary: summary ?? this.summary,
    title: title ?? this.title,
    tags: tags ?? this.tags,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
    oid: json["oid"],
    author: json["author"],
    category: json["category"],
    content: json["content"],
    image: json["image"] != null ? ImageModel.fromJson(json["image"]) : null,
    language: json["language"],
    publishedAt: json["publishedAt"],//DateTime.parse(json["publishedAt"]),
    status: json["status"],
    summary: json["summary"],
    title: json["title"],
    tags: json["tags"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] != null
        ? DateTime.parse(json["updatedAt"])
        : null, // <-- aman walaupun null
  );

  Map<String, dynamic> toJson() => {
    "oid": oid,
    "author": author,
    "category": category,
    "content": content,
    "image": image,
    "language": language,
    "publishedAt": publishedAt,// publishedAt.toIso8601String(),
    "status": status,
    "summary": summary,
    "title": title,
    "tags": tags,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}
