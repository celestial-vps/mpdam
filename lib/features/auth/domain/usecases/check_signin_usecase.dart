import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../repositories/auth_repository.dart';

class CheckSigninUseCase implements UseCase<bool, NoParams> {
  CheckSigninUseCase(this.repository);

  final AuthRepository repository;

  @override
  Future<Either<Failure, bool>> call(NoParams params) => repository.isSignedIn();
}
