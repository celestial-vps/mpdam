import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/customer/domain/entities/update_customer_entity.dart';
import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';
import '../../../../core/error/failure.dart';

class UpdateCustomerUseCase  implements UseCase<Unit, UpdateCustomerEntity> {
  final CustomerRepository customerRepository;

  const UpdateCustomerUseCase (this.customerRepository);

  @override
  Future<Either<Failure, Unit>> call(UpdateCustomerEntity params) async {
    return customerRepository.updateCustomer(params);
  }
}
