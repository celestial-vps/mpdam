import 'package:dartz/dartz.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/features/auth/domain/entities/login_param.dart';
import 'package:mpdam/features/auth/domain/entities/register_param.dart';
import 'package:mpdam/features/auth/domain/entities/user.dart';


abstract class AuthRepository {
  // Future<Either<Failure, bool>> isSignedIn();
  Future<Either<Failure, User>> login(LoginParam loginParam);
  Future<Either<Failure, Unit>> register(RegisterParam registerParam);
  // Future<Either<Failure, Unit>> logout();
}
