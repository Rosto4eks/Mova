import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mova/application/application.dart';
import 'package:mova/features/study/domain/repository/repository.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mova/features/users/service.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var userRepository = UserRepository();
  var userService = UserService(userRepository);

  var studyRepository = await StudyRepository().init();
  var studyService = StudyService(studyRepository, "", 2);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(App(studyService)));
}
