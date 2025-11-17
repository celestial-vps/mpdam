 
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/bank/domain/entities/bank_entity.dart';
import 'package:mpdam/features/bank/domain/repositories/bank_repository.dart';

class GetInitBankUseCase implements UseCase<BankEntity, PaggingParam> {
  final BankRepository customerRepository;

  const GetInitBankUseCase(this.customerRepository);

  @override
  Future<Either<Failure, BankEntity>> call(PaggingParam params) async {
    
    return await customerRepository.getAllBankPagging(params);
  }
}
