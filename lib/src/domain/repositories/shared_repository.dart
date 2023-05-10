import 'package:dartz/dartz.dart';
import 'package:rundolist/src/domain/entities/promt.dart';

abstract class SharedRepository {
  Future<Either<Error, Duration>> readDuration();
  Future<Either<Error, Unit>> updateDuration(Duration duration);

  Future<Either<Error, List<Promt>>> readPromts();
  Future<Either<Error, Unit>> updatePromts(List<Promt> promts);

  Future<Either<Error, int>> readCounter();
  Future<Either<Error, Unit>> updateCounter(int count);

  Future<Either<Error, Unit>> clearPromts();
}
