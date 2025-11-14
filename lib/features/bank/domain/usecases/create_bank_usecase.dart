
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/bank/domain/entities/create_bank_entity.dart';
import 'package:mpdam/features/bank/domain/repositories/bank_repository.dart';

import '../../../../core/error/failure.dart';

class CreateBankUseCase implements UseCase<Unit, CreateBankEntity> {
  final BankRepository bankRepository;

  const CreateBankUseCase(this.bankRepository);

  @override
  Future<Either<Failure, Unit>> call(CreateBankEntity params) async {
    return bankRepository.createBank(params);
  }
}
