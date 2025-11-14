import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/bank/domain/entities/update_bank_entity.dart';
import 'package:mpdam/features/bank/domain/repositories/bank_repository.dart';
import '../../../../core/error/failure.dart';

class UpdateBankUseCase  implements UseCase<Unit, UpdateBankEntity> {
  final BankRepository bankRepository;

  const UpdateBankUseCase (this.bankRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateBankEntity params) async {
    return bankRepository.updateBank(params);
  }
}
