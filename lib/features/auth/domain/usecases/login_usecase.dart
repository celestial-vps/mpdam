import 'package:dartz/dartz.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/usecase/usecase.dart';
import 'package:mpdam/features/auth/domain/entities/login_param.dart';
import 'package:mpdam/features/auth/domain/entities/user.dart';
import 'package:mpdam/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<User, LoginParam> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParam params) {
    return repository.login(params);
  }
}
