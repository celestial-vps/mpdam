import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/exception.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/network/network_info.dart';
import 'package:mpdam/features/customer/data/datasources/customer_remote_datasource.dart';
import 'package:mpdam/features/customer/data/models/create_customer_model.dart';
import 'package:mpdam/features/customer/data/models/mapper/customer_mapper.dart';
import 'package:mpdam/features/customer/data/models/update_customer_model.dart';
import 'package:mpdam/features/customer/domain/entities/create_customer_entity.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';
import 'package:mpdam/features/customer/domain/entities/update_customer_entity.dart';
import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';
import 'package:mpdam/features/customer/data/models/mapper/list_customer_mapper.dart';

class CustomerRepositoryImplementation extends CustomerRepository {
  final CustomerRemoteDataSource customerRemoteDataSource;
  final NetworkInfo networkInfo;
  CustomerRepositoryImplementation({
    required this.customerRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, CustomerEntity>> getAllCustomerPagging(
    PaggingParam paggingParam,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        //
        final result = await customerRemoteDataSource.getAllCustomers(
          pageIndex: paggingParam.pageIndex,
          pageSize: paggingParam.pageSize,
          search: paggingParam.search,
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
  Future<Either<Failure, Unit>> createCustomer(
    CreateCustomerEntity data,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        //
        await customerRemoteDataSource.createCustomer(
          CreateCustomerModel(
            firstName: data.firstName,
            middleName: data.middleName,
            lastName: data.lastName,
            phoneNumber: data.phoneNumber,
            address: data.address,
            email: data.email,
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
  Future<Either<Failure, Unit>> deleteCustomer(String oid) async {
    if (await networkInfo.isConnected) {
      try {
        //
        await customerRemoteDataSource.deleteCustomer(oid);

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
  Future<Either<Failure, Customer>> getCustomerById(String oid) async {
    if (await networkInfo.isConnected) {
      try {
        //
        final result = await customerRemoteDataSource.getCustomerById(oid);

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
  Future<Either<Failure, Unit>> updateCustomer(
    UpdateCustomerEntity data,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        //
        await customerRemoteDataSource.updateCustomer(
          data.oid,
          UpdateCustomerModel(
            firstName: data.firstName,
            middleName: data.middleName,
            lastName: data.lastName,
            phoneNumber: data.phoneNumber,
            address: data.address,
            email: data.email,
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
}
