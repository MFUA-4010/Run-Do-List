import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/core/usecase/usecase.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';

class UpdateCachedThemeUseCase extends UseCase<Unit, ThemeMode> {
  late final SharedRepository _repository;

  UpdateCachedThemeUseCase() {
    _repository = services<SharedRepository>();
  }

  @override
  Future<Either<Error, Unit>> call(ThemeMode param) {
    return _repository.updateTheme(param);
  }
}
