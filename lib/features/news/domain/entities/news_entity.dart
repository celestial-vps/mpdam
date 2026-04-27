import 'package:equatable/equatable.dart';
import 'package:mpdam/core/entity/pagging_entity.dart';
import 'package:mpdam/core/models/image_model.dart';

class NewsEntity extends Equatable {
  final PaggingEntity pagination;
  final List<News> data;

  const NewsEntity({required this.pagination, required this.data});

  @override
  List<Object?> get props => [pagination, data];
}

class News extends Equatable {
  final String oid;
  final String author;
  final String category;
  final String content;
  final ImageModel? image;
  final String language;
  final String publishedAt;
  final String status;
  final String summary;
  final String tags;
  final String title;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const News({
    required this.oid,
    required this.author,
    required this.category,
    required this.content,
    required this.image,
    required this.language,
    required this.publishedAt,
    required this.status,
    required this.summary,
    required this.tags,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  List<Object?> get props => [
    oid,
    author,
    category,
    content,
    image,
    language,
    publishedAt,
    status,
    summary,
    tags,
    title,
    createdAt,
    updatedAt, // bisa null
  ]; 
}
