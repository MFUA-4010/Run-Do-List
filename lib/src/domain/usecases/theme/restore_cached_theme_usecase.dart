import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class RestoreCachedThemeUseCase extends UseCase<ThemeMode, NoParam> {
  late final SharedRepository _repository;

  RestoreCachedThemeUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, ThemeMode>> call(NoParam param) {
    return _repository.readTheme();
  }
}
