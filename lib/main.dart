import 'package:flutter/material.dart';
import 'package:rundolist/core/injector/services.dart';
import 'package:rundolist/src/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(const App());
}
