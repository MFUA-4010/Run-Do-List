import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:rundolist/src/presentation/controllers/duration/duration_bloc.dart';
import 'package:rundolist/src/presentation/controllers/promt/promt_bloc.dart';

final services = GetIt.I;

FutureOr<void> initServices() async {
  services.registerLazySingleton<DurationBloc>(
    () => DurationBloc(),
  );

  services.registerLazySingleton<PromtBloc>(
    () => PromtBloc(),
  );
}