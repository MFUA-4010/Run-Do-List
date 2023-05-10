import 'package:dartz/dartz.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class ClearCachedPromtsUseCase extends UseCase<Unit, NoParam> {
  late final SharedRepository _repository;

  ClearCachedPromtsUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, Unit>> call(NoParam param) {
    return _repository.clearPromts();
  }
}
