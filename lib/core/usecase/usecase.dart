import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

const NoParams noParams = NoParams._internal();

class NoParams extends Equatable {
  const NoParams._internal();

  const NoParams();
  @override
  List<Object> get props => [unit];
}
