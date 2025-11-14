
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/bank/domain/repositories/bank_repository.dart';

class DeleteBankUseCase implements UseCase<Unit, String> {
  final BankRepository bankRepository;

  const DeleteBankUseCase(this.bankRepository);

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return bankRepository.deleteBank(params);
  }
}
