import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/exception.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/network/network_info.dart';
import 'package:mpdam/features/news/data/datasource/news_remote_datasource.dart';
import 'package:mpdam/features/news/data/dtos/create_news_dto.dart';
import 'package:mpdam/features/news/data/dtos/filter_news_dto.dart';
import 'package:mpdam/features/news/data/dtos/update_news_dto.dart';
import 'package:mpdam/features/news/data/models/mapper/news_mapper.dart';
import 'package:mpdam/features/news/data/models/mapper/list_news_mapper.dart';
import 'package:mpdam/features/news/domain/entities/news_entity.dart';
import 'package:mpdam/features/news/domain/entities/create_news_entity.dart';
import 'package:mpdam/features/news/domain/entities/update_news_entity.dart';
import 'package:mpdam/features/news/domain/repositories/news_repository.dart';

class NewsRepositoryImplementation extends NewsRepository {
  final NewsRemoteDataSource newsRemoteDataSource;
  final NetworkInfo networkInfo;
  NewsRepositoryImplementation({
    required this.newsRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, NewsEntity>> getAllNewsPagging(
    PaggingParam paggingParam,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        //
        final filterDto = FilterNewsDtoMapper.fromMap(paggingParam.search);

        final result = await newsRemoteDataSource.getAllNewss(
          pageIndex: paggingParam.pageIndex,
          pageSize: paggingParam.pageSize,
          filterNewsDto: filterDto,
        );

        return Right(result.toDomain());
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(e.message));
      } on UnauthorisedException catch (e) {
        return Left(UnauthorisedFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on FetchDataException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on InvalidCredentialException catch (e) {
        return Left(InvalidCredentialFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on NetworkException {
        return const Left(
          NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return const Left(UnknowFailure('Terjadi kesalahan'));
      }
    } else {
      return Left(
        NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
      );
    }
  }

  @override
  Future<Either<Failure, News>> getNewsById(String oid) async {
    if (await networkInfo.isConnected) {
      try {
        //
        final result = await newsRemoteDataSource.getNewsById(oid);

        return Right(result.toDomain());
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(e.message));
      } on UnauthorisedException catch (e) {
        return Left(UnauthorisedFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on FetchDataException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on InvalidCredentialException catch (e) {
        return Left(InvalidCredentialFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on NetworkException {
        return const Left(
          NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return const Left(UnknowFailure('Terjadi kesalahan'));
      }
    } else {
      return Left(
        NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> createNews(CreateNewsEntity data) async {
    if (await networkInfo.isConnected) {
      try {
        //
        await newsRemoteDataSource.createNews(
          CreateNewsDto(
            author: data.author,
            category: data.category,
            content: data.content,
            image: data.image,
            language: data.language,
            publishedAt: data.publishedAt,
            status: data.status,
            summary: data.summary,
            tags: data.tags,
            title: data.title,
          ),
        );

        return Right(unit);
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(e.message));
      } on UnauthorisedException catch (e) {
        return Left(UnauthorisedFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on FetchDataException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on InvalidCredentialException catch (e) {
        return Left(InvalidCredentialFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on NetworkException {
        return const Left(
          NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return const Left(UnknowFailure('Terjadi kesalahan'));
      }
    } else {
      return Left(
        NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNews(UpdateNewsEntity data) async {
    if (await networkInfo.isConnected) {
      try {
        //
        await newsRemoteDataSource.updateNews(
          data.oid,
          UpdateNewsDto(
            author: data.author,
            content: data.content,
            category: data.category,
            image: data.image,
            language: data.language,
            publishedAt: data.publishedAt,
            status: data.status,
            summary: data.summary,
            tags: data.tags,
            title: data.title,
          ),
        );

        return Right(unit);
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(e.message));
      } on UnauthorisedException catch (e) {
        return Left(UnauthorisedFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on FetchDataException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on InvalidCredentialException catch (e) {
        return Left(InvalidCredentialFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on NetworkException {
        return const Left(
          NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return const Left(UnknowFailure('Terjadi kesalahan'));
      }
    } else {
      return Left(
        NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNews(String oid) async {
    if (await networkInfo.isConnected) {
      try {
        //
        await newsRemoteDataSource.deleteNews(oid);

        return Right(unit);
      } on BadRequestException catch (e) {
        return Left(BadRequestFailure(e.message));
      } on UnauthorisedException catch (e) {
        return Left(UnauthorisedFailure(e.message));
      } on NotFoundException catch (e) {
        return Left(NotFoundFailure(e.message));
      } on FetchDataException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on InvalidCredentialException catch (e) {
        return Left(InvalidCredentialFailure(e.message));
      } on ServerException catch (e) {
        return Left(ServerFailure(e.message ?? ''));
      } on NetworkException {
        return const Left(
          NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return const Left(UnknowFailure('Terjadi kesalahan'));
      }
    } else {
      return Left(
        NetworkFailure("Koneksi internet anda terputus mohon coba lagi"),
      );
    }
  }
}
