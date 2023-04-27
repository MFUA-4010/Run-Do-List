import 'package:dartz/dartz.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class RestoreDurationUseCase extends UseCase<Duration, NoParam> {
  late final SharedRepository _repository;

  RestoreDurationUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, Duration>> call(NoParam param) async {
    return _repository.readDuration();
  }
}
