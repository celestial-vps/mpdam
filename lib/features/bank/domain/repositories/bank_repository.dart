 
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:dartz/dartz.dart';

abstract class BankRepository {
  Future<Either<Failure, BankEntity>> getAllBankPagging(PaggingParam paggingParam);  
  // Future<Either<Failure, Bank>> getBankById(String oid);
  // Future<Either<Failure, Unit>> deleteBank(String oid);
  // Future<Either<Failure, Unit>> createBank(CreateBankEntity data);
  // Future<Either<Failure, Unit>> updateBank(UpdateBankEntity data);
}
