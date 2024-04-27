import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mova/application/application.dart';
import 'package:mova/features/book/domain/repository/dto.dart';
import 'package:mova/features/book/domain/repository/repository.dart';
import 'package:mova/features/book/domain/usecase/service.dart';
import 'package:mova/features/study/domain/repository/dto.dart';
import 'package:mova/features/study/domain/repository/repository.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mova/features/users/domain/service.dart';
import 'package:mova/features/users/repository/dto.dart';
import 'package:overlay_support/overlay_support.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskDTOAdapter());
  Hive.registerAdapter(LessonDTOAdapter());
  Hive.registerAdapter(ModuleDTOAdapter());
  Hive.registerAdapter(UserDTOAdapter());
  Hive.registerAdapter(BookDTOAdapter());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  var userRepository = await UserRepository().init();
  var studyRepository = await StudyRepository().init();
  var bookRepository = await BookRepository().init();

  var userService = UserService(userRepository);
  var studyService = StudyService(studyRepository, userRepository, "", 2);
  var bookService = BookService(bookRepository, userRepository);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(
      OverlaySupport(child: App(studyService, userService, bookService))));
}
