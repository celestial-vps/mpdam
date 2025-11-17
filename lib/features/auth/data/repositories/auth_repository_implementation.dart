import 'package:dartz/dartz.dart';
import 'package:mpdam/core/error/failure.dart';
import 'package:mpdam/core/network/network_info.dart';
import 'package:mpdam/core/storage/auth_local_datasource.dart';
import 'package:mpdam/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:mpdam/features/auth/data/dtos/login_dto.dart';
import 'package:mpdam/features/auth/domain/entities/login_param.dart';
import 'package:mpdam/features/auth/domain/entities/register_param.dart';
import 'package:mpdam/features/auth/domain/entities/user.dart';
import 'package:mpdam/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImplementation extends AuthRepository {
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;
  final NetworkInfo network;

  AuthRepositoryImplementation({
    required this.remote,
    required this.local,
    required this.network,
  });

  @override
  Future<Either<Failure, User>> login(LoginParam loginParam) async {
    if (!await network.isConnected) {
      return const Left(NetworkFailure("No internet connection"));
    }

    try {
      final dto = LoginDto(
        email: loginParam.email,
        password: loginParam.password,
      );

      final user = await remote.login(dto);

      // ⭐ SIMPAN TOKEN
      await local.persistToken(user.token);
      print('Login token: ${user.token}');
      return Right(user);
    } catch (e) {
      return Left(UnknowFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> register(RegisterParam registerParam) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
