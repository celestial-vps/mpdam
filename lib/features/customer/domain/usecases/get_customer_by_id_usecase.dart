import 'package:dartz/dartz.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/customer/domain/entities/customer_entity.dart';
import 'package:mpdam/features/customer/domain/repositories/customer_repository.dart';
import '../../../../core/error/failure.dart';

class GetCustomerByIdUseCase implements UseCase<Customer, String> {
  final CustomerRepository customerRepository;

  GetCustomerByIdUseCase(this.customerRepository);

  @override
  Future<Either<Failure, Customer>> call(String customerId) async {
    return customerRepository.getCustomerById(customerId);
  }
}
