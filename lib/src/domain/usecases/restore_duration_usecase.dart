import 'package:dartz/dartz.dart';
import 'package:rundolist/core/usecase/usecase.dart';

class RestoreDurationUseCase extends UseCase<Duration, NoParam> {
  @override
  Future<Either<Error, Duration>> call(NoParam param) async {
    return Left(UnimplementedError());
  }
}
