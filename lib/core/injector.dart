import 'dart:async';

import 'package:dotenv/dotenv.dart';
import 'package:get_it/get_it.dart';

final GetIt services = GetIt.I;

abstract class Injector {
  FutureOr<void> initServices();
}

class DevInjector extends Injector {
  @override
  FutureOr<void> initServices() async {
    //! Load project env configuration
    DotEnv().load(['.env']);
  }
}
