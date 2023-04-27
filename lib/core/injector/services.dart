import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rundolist/src/presentation/controllers/duration/duration_bloc.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';

/// Dependency injector Global storage
final services = GetIt.I;

/// Dependency injection Global procedure
FutureOr<void> initServices() async {
  //! Register Global BLoC's

  services.registerLazySingleton<DurationBloc>(
    () => DurationBloc(),
  );

  services.registerLazySingleton<PromtBloc>(
    () => PromtBloc(),
  );
}
