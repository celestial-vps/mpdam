import 'package:mpdam/features/news/data/models/news_model.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';

extension NewsMapper on List<NewsModel> {
  List<News> toDomain() => List.from(map((e) => e.toDomain()));
}

extension NewsModelMapper on NewsModel {
  News toDomain() => News(
    oid: oid,
    author: author,
    category: category,
    content: content,
    image: image,    
    language: language,
    publishedAt: publishedAt,
    status: status,
    summary: summary,
    tags: tags,
    createdAt: createdAt,
    updatedAt: updatedAt,
    title: '',
  );
}
