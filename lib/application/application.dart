import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/pages/main_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    var repository = Repository();
    var studyService = StudyService(repository, "", 2);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<StudyProvider>(
            create: (context) => StudyProvider(studyService))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Mova",
        home: MainPage(),
      ),
    );
  }
}
