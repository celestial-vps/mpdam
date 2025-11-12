import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mpdam/core/error/exception.dart';
import 'package:mpdam/core/error/failure.dart';

Future<Either<Failure, T>> safeApiCall<T>(Future<T> Function() apiCall) async {
  try {
    final result = await apiCall();
    return Right(result);
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
    return const Left(NetworkFailure("Koneksi internet anda terputus mohon coba lagi"));
  } catch (e) {
    if (kDebugMode) print(e);
    return const Left(UnknowFailure('Terjadi kesalahan'));
  }
}
