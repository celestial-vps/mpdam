
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/customer/domain/entities/create_customer_entity.dart';
import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';

import '../../../../core/error/failure.dart';

class CreateCustomerUseCase implements UseCase<Unit, CreateCustomerEntity> {
  final CustomerRepository customerRepository;

  const CreateCustomerUseCase(this.customerRepository);

  @override
  Future<Either<Failure, Unit>> call(CreateCustomerEntity params) async {
    return customerRepository.createCustomer(params);
  }
}
