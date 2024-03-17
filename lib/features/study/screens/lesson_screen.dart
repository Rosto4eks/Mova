import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/features/study/screens/insert_words_task_screen.dart';
import 'package:mova/features/study/screens/complete_screen.dart';
import 'package:mova/features/study/screens/reward_screen.dart';
import 'package:mova/features/study/screens/translate_text_task_screen.dart';
import 'package:mova/features/study/screens/translate_word_task_screen.dart';
import 'package:mova/features/study/screens/write_translation_task_screen.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  final int lessonIndex;
  const LessonScreen(this.lessonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    late Widget w;
    var lesson = Provider.of<StudyProvider>(context).getLesson(lessonIndex);
    late Task task;
    try {
      task = lesson.nextTask();
      if (task is TranslateWordTask) {
        w = const TranslateWordTaskScreen();
      } else if (task is InsertWordsTask) {
        w = const InsertWordsTaskScreen();
      } else if (task is TranslateTextTask) {
        w = const TranslateTextTaskScreen();
      } else {
        w = const WriteTranslationTaskScreen();
      }
    } catch (e) {
      print(lesson.everCompleted);
      return Provider.of<StudyProvider>(context).isLessonEverFinished()
          ? CompleteScreen(lesson, lessonIndex)
          : RewardScreen(lesson, lessonIndex);
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomLeft,
            radius: 1.5,
            colors: [
              lightBlue,
              lightGrey,
            ],
          ),
        ),
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 70, bottom: 10),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: lesson.elementsCompleted.toDouble() /
                  lesson.elementsCount.toDouble(),
              color: const Color.fromARGB(255, 123, 248, 161),
              minHeight: 7,
              borderRadius: BorderRadius.circular(15),
            ),
            Expanded(
              child: w,
            ),
          ],
        ),
      ),
    );
  }
}
