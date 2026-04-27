import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';
import 'package:mpdam/features/news/domain/repositories/news_repository.dart';
import '../../../../core/error/failure.dart';

class GetNewsByIdUseCase implements UseCase<News, String> {
  final NewsRepository newsRepository;

  GetNewsByIdUseCase(this.newsRepository);

  @override
  Future<Either<Failure, News>> call(String newsId) async {
    return newsRepository.getNewsById(newsId);
  }
}
