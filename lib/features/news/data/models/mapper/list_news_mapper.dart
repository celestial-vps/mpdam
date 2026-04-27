import 'package:mpdam/core/models/mapper/pagging_mapper.dart';
import 'package:mpdam/features/news/data/models/list_news_model.dart';
import 'package:mpdam/features/news/data/models/mapper/news_mapper.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';

extension ListNewsMapper on ListNewsModel {
  NewsEntity toDomain() =>
      NewsEntity(pagination: pagination.toDomain(), data: data.toDomain());
}
