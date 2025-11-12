 
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/entity/pagging_param.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';
import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';

class GetInitCustomerUseCase implements UseCase<CustomerEntity, PaggingParam> {
  final CustomerRepository customerRepository;

  const GetInitCustomerUseCase(this.customerRepository);

  @override
  Future<Either<Failure, CustomerEntity>> call(PaggingParam params) async {
    return await customerRepository.getAllCustomerPagging(params);
  }
}
