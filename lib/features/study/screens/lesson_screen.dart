import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/features/study/widgets/insert_words_task_template.dart';
import 'package:mova/features/study/widgets/translate_text_task_template.dart';
import 'package:mova/features/study/widgets/translate_word_task_template.dart';
import 'package:mova/features/study/widgets/write_translation_task_template.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  final int lessonIndex;
  const LessonScreen(this.lessonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    var lesson = Provider.of<StudyProvider>(context).getLesson(lessonIndex);
    late Task task;
    try {
      task = lesson.nextTask();
    } catch (e) {
      return Text("aboba");
    }
    late Widget w;
    if (task is TranslateWordTask) {
      w = TranslateWordTaskTemplate(lessonIndex);
    } else if (task is InsertWordsTask) {
      w = InsertWordsTaskTemplate(lessonIndex);
    } else if (task is TranslateTextTask) {
      w = TranslateTextTaskTemplate(lessonIndex);
    } else {
      w = WriteTranslationTaskTemplate(lessonIndex);
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 10, right: 10, top: 70, bottom: 10),
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
