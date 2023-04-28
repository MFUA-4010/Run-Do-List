import 'package:dartz/dartz.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class UpdateDurationUseCase extends UseCase<Unit, Duration> {
  late final SharedRepository _repository;

  UpdateDurationUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, Unit>> call(Duration param) {
    return _repository.updateDuration(param);
  }
}
