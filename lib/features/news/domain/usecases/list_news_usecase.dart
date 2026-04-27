 
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';
import 'package:mpdam/features/news/domain/repositories/news_repository.dart';

class GetInitNewsUseCase implements UseCase<NewsEntity, PaggingParam> {
  final NewsRepository newsRepository;

  const GetInitNewsUseCase(this.newsRepository);

  @override
  Future<Either<Failure, NewsEntity>> call(PaggingParam params) async {
    
    return await newsRepository.getAllNewsPagging(params);
  }
}
