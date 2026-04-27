
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/news/domain/entities/create_news_entity.dart';
import 'package:mpdam/features/news/domain/repositories/news_repository.dart';

import '../../../../core/error/failure.dart';

class CreateNewsUseCase implements UseCase<Unit, CreateNewsEntity> {
  final NewsRepository newsRepository;

  const CreateNewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, Unit>> call(CreateNewsEntity params) async {
    return newsRepository.createNews(params);
  }
}
