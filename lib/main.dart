import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/app/app.dart';
import 'package:test_app/core/di/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initDependencies();

  runApp(const App());
}
