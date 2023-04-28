import 'package:dartz/dartz.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class RestoreCounterUseCase extends UseCase<int, NoParam> {
  late final SharedRepository _repository;

  RestoreCounterUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, int>> call(NoParam param) {
    return _repository.readCounter();
  }
}
