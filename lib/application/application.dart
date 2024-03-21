import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/module_provider.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/pages/main_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final StudyService studyService;
  const App(this.studyService, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudyProvider>(
          create: (context) => StudyProvider(studyService),
        ),
        ChangeNotifierProvider<ModuleProvider>(
          create: (context) => ModuleProvider(0),
        ),
        ChangeNotifierProvider<LessonProvider>(
          create: (context) => LessonProvider(0),
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
