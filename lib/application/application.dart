import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/study/providers/module_provider.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/features/users/domain/service.dart';
import 'package:mova/features/users/providers/signin_provider.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/presentation/pages/main_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final StudyService studyService;
  final UserService userService;
  const App(this.studyService, this.userService, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudyProvider>(
          create: (context) => StudyProvider(studyService),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(userService),
        ),
        ChangeNotifierProvider<ModuleProvider>(
          create: (context) => ModuleProvider(0),
        ),
        ChangeNotifierProvider<LessonProvider>(
          create: (context) => LessonProvider(0),
        ),
        ChangeNotifierProvider<SigninProvider>(
          create: (context) => SigninProvider(),
        ),
        ChangeNotifierProvider<SignupProvider>(
          create: (context) => SignupProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(fontFamily: 'Geologica'),
        debugShowCheckedModeBanner: false,
        title: "Mova",
        home: const MainPage(),
      ),
    );
  }
}
