 
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:mpdam/features/news/domain/entities/create_news_entity.dart';
import 'package:mpdam/features/news/domain/entities/update_news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, NewsEntity>> getAllNewsPagging(PaggingParam paggingParam);  
  Future<Either<Failure, News>> getNewsById(String oid);  
  Future<Either<Failure, Unit>> createNews(CreateNewsEntity data);
  Future<Either<Failure, Unit>> updateNews(UpdateNewsEntity data);
  Future<Either<Failure, Unit>> deleteNews(String oid);
}
