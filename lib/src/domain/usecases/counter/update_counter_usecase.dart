import 'package:dartz/dartz.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class UpdateCounterUseCase extends UseCase<Unit, int> {
  late final SharedRepository _repository;

  UpdateCounterUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, Unit>> call(int param) {
    return _repository.updateCounter(param);
  }
}
