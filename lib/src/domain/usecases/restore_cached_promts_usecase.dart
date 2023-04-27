import 'package:dartz/dartz.dart';
import 'package:rundolist/core/usecase/usecase.dart';

class RestoreCachedPromtsUseCase extends UseCase<Unit, NoParam> {
  @override
  Future<Either<Error, Unit>> call(NoParam param) async {
    return Left(UnimplementedError());
  }
}
