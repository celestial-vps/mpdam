
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/news/domain/repositories/news_repository.dart';

class DeleteNewsUseCase implements UseCase<Unit, String> {
  final NewsRepository newsRepository;

  const DeleteNewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return newsRepository.deleteNews(params);
  }
}
