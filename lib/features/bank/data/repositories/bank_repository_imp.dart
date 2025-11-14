
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/exception.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/network/network_info.dart';
import 'package:mpdam/features/bank/data/datasource/bank_remote_datasource.dart';
import 'package:mpdam/features/bank/data/dtos/create_bank_dto.dart';
import 'package:mpdam/features/bank/data/dtos/filter_bank_dto.dart';
import 'package:mpdam/features/bank/data/dtos/update_bank_dto.dart';
import 'package:mpdam/features/bank/data/models/mapper/bank_mapper.dart';
import 'package:mpdam/features/bank/data/models/mapper/list_bank_mapper.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:mpdam/features/bank/domain/entities/create_bank_entity.dart';
import 'package:mpdam/features/bank/domain/entities/update_bank_entity.dart';
import 'package:mpdam/features/bank/domain/repositories/bank_repository.dart';

class BankRepositoryImplementation extends BankRepository {
  final BankRemoteDataSource bankRemoteDataSource;
  final NetworkInfo networkInfo;
  BankRepositoryImplementation({
    required this.bankRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, BankEntity>> getAllBankPagging(
    PaggingParam paggingParam,
  ) async {
    if (await networkInfo.isConnected) {
      try {

        
        //
        final filterDto = FilterBankDtoMapper.fromMap(paggingParam.search);

        final result = await bankRemoteDataSource.getAllBanks(
          pageIndex: paggingParam.pageIndex,
          pageSize: paggingParam.pageSize,   
          filterBankDto: filterDto,       
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
  Future<Either<Failure, Bank>> getBankById(String oid) async {
    if (await networkInfo.isConnected) {
      try {
        //
        final result = await bankRemoteDataSource.getBankById(oid);

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
  Future<Either<Failure, Unit>> createBank(CreateBankEntity data) async{
   if (await networkInfo.isConnected) {
      try {
        //
        await bankRemoteDataSource.createBank(
          CreateBankDto(
            bankCode: data.bankCode,
            bankName: data.bankName,            
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
  Future<Either<Failure, Unit>> updateBank(
    UpdateBankEntity data,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        //
        await bankRemoteDataSource.updateBank(
          data.oid,
          UpdateBankDto(
            bankCode: data.bankCode,
            bankName: data.bankName,            
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
  Future<Either<Failure, Unit>> deleteBank(String oid) async {
    if (await networkInfo.isConnected) {
      try {
        //
        await bankRemoteDataSource.deleteBank(oid);

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