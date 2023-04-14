import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../failures/failure.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(final P param);
}

class NoParam extends Equatable {
  @override
  List<Object?> get props => [];
}
