import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rundolist/src/data/implements/paste_cloud_repository_impl.dart';
import 'package:rundolist/src/data/implements/shared_repository_impl.dart';
import 'package:rundolist/src/domain/repositories/cloud_repository.dart';
import 'package:rundolist/src/domain/repositories/shared_repository.dart';
import 'package:rundolist/src/presentation/controllers/counter/counter_bloc.dart';
import 'package:rundolist/src/presentation/controllers/duration/duration_bloc.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';
import 'package:rundolist/src/presentation/controllers/pseudo/pseudo_bloc.dart';
import 'package:rundolist/src/presentation/controllers/theme/theme_bloc.dart';

/// Dependency injector Global storage
final services = GetIt.I;

/// Dependency injection Global procedurAPI_KEYe
FutureOr<void> initServices() {
  //! Register Repositories

  services.registerLazySingleton<CloudRepository>(
    () => PasteCloudRepositoryImpl(),
  );

  services.registerLazySingleton<SharedRepository>(
    () => SharedRepositoryImpl(),
  );

  //! Register Global BLoC's

  services.registerLazySingleton<CounterBloc>(
    () => CounterBloc(),
  );

  services.registerLazySingleton<DurationBloc>(
    () => DurationBloc(),
  );

  services.registerLazySingleton<PromtBloc>(
    () => PromtBloc(),
  );

  services.registerLazySingleton<ThemeBloc>(
    () => ThemeBloc(),
  );

  services.registerLazySingleton<PseudoBloc>(
    () => PseudoBloc(),
  );
}
