import 'package:dartz/dartz.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class RestoreCachedPromtsUseCase extends UseCase<List<Promt>, NoParam> {
  late final SharedRepository _repository;

  RestoreCachedPromtsUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, List<Promt>>> call(NoParam param) async {
    return _repository.readPromts();
  }
}
