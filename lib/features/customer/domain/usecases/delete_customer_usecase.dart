
import 'package:dartz/dartz.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';

class DeleteCustomerUseCase implements UseCase<Unit, String> {
  final CustomerRepository customerRepository;

  const DeleteCustomerUseCase(this.customerRepository);

  @override
  Future<Either<Failure, Unit>> call(String params) {
    return customerRepository.deleteCustomer(params);
  }
}
