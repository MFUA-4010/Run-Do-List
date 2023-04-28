import 'package:dotenv/dotenv.dart';

class GlobalEnvironment {
  late final DotEnv env;

  GlobalEnvironment() {
    env = DotEnv()..load(['.env']);
  }

  String? get apiKey => env['API_KEY'];
  String? get hash => env['HASH'];
  String? get salt => env['SALT'];
}
