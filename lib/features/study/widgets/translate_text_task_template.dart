import 'package:flutter/material.dart';
import 'package:mova/features/study/components/task_componetns.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class TranslateTextTaskTemplate extends StatelessWidget {
  final int lessonIndex;
  const TranslateTextTaskTemplate(this.lessonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    var lesson = Provider.of<StudyProvider>(context).getLesson(lessonIndex);
    var task =
        Provider.of<StudyProvider>(context).getTask() as TranslateTextTask;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.topLeft,
          child: const Text(
            "Расстаўце словы",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: color2,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
          child: Text(
            task.text,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        GestureDetector(
          onTap: () {
            task.removeLast();
            Provider.of<StudyProvider>(context, listen: false).refresh();
          },
          child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
            child: Text(
              task.translation,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(bottom: 100),
              alignment: Alignment.bottomCenter,
              child: Wrap(
                spacing: 20,
                runSpacing: 10,
                children: task.words
                    .map<GestureDetector>(
                      (e) => GestureDetector(
                        onTap: () {
                          task.insertWord(e);
                          Provider.of<StudyProvider>(context, listen: false)
                              .refresh();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 20),
                          decoration: BoxDecoration(
                              color: color2,
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            e,
                            style: TextStyle(color: color3, fontSize: 23),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )),
        GestureDetector(
          onTap: () {
            checkTask(context, task.check());
          },
          child: Container(
            height: 60,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 123, 248, 161),
                borderRadius: BorderRadius.circular(15)),
            alignment: Alignment.center,
            child: const Text(
              "праверыць",
              style: TextStyle(
                color: color3,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
