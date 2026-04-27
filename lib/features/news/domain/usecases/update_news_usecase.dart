import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/news/domain/entities/update_news_entity.dart';
import 'package:mpdam/features/news/domain/repositories/news_repository.dart';
import '../../../../core/error/failure.dart';

class UpdateNewsUseCase  implements UseCase<Unit, UpdateNewsEntity> {
  final NewsRepository newsRepository;

  const UpdateNewsUseCase (this.newsRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateNewsEntity params) async {
    return newsRepository.updateNews(params);
  }
}
