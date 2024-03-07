import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mova/application/application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const App()));
  runApp(const App());
}
