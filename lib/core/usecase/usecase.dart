import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Abstract
abstract class UseCase<T, P> {
  Future<Either<Error, T>> call(P param);
}

class NoParam extends Equatable {
  const NoParam();

  @override
  List<Object?> get props => [];
}
