import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mova/application/application.dart';
import 'package:mova/features/study/domain/repository/repository.dart';
import 'package:mova/features/study/domain/usecase/service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var repository = await StudyRepository().init();
  var studyService = StudyService(repository, "", 2);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(App(studyService)));
}
