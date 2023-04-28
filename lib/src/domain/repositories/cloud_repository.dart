import 'package:dartz/dartz.dart';
import 'package:rundolist/src/domain/entities/promt.dart';

abstract class CloudReopository {
  Future<Either<Error, String>> upload(List<Promt> promts);
  Future<Either<Error, List<Promt>>> import(String key);
}
