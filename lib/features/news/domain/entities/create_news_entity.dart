import 'package:equatable/equatable.dart';
import 'package:mpdam/core/models/image_model.dart';

class CreateNewsEntity extends Equatable {
  final String oid;
  final String author;
  final String category;
  final String content;
  final String image;
  final String language;
  final String publishedAt;
  final String status;
  final String summary;
  final String tags;
  final String title;

  const CreateNewsEntity({
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
  });

  @override
  List<Object?> get props => [
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
  ];
}
