import 'package:dotenv/dotenv.dart';

class GlobalEnv {
  late final DotEnv env;

  GlobalEnv() {
    env = DotEnv()..load(['.env']);
  }

  String? get apiKey => env['API_KEY'];
  String? get hash => env['HASH'];
  String? get salt => env['SALT'];
}
