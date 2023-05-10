import 'package:dartz/dartz.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/entities/promt.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class UpdateCachedPromtsUseCase extends UseCase<Unit, List<Promt>> {
  late final SharedRepository _repository;

  UpdateCachedPromtsUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, Unit>> call(List<Promt> param) {
    return _repository.updatePromts(param);
  }
}
