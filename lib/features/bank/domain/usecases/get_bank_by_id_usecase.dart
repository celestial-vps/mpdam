import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:mpdam/features/bank/domain/repositories/bank_repository.dart';
import '../../../../core/error/failure.dart';

class GetBankByIdUseCase implements UseCase<Bank, String> {
  final BankRepository bankRepository;

  GetBankByIdUseCase(this.bankRepository);

  @override
  Future<Either<Failure, Bank>> call(String bankId) async {
    return bankRepository.getBankById(bankId);
  }
}
