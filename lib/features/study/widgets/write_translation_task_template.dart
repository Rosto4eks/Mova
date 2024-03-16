import 'package:flutter/material.dart';
import 'package:mova/features/study/components/task_componetns.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class WriteTranslationTaskTemplate extends StatelessWidget {
  final int lessonIndex;
  const WriteTranslationTaskTemplate(this.lessonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    var lesson = Provider.of<StudyProvider>(context).getLesson(lessonIndex);
    var task =
        Provider.of<StudyProvider>(context).getTask() as WriteTranslationTask;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.topLeft,
          child: const Text(
            "Перакладзіце тэкст",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: color2,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 70),
          child: Column(
            children: [
              Text(
                task.text,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Material(
                  child: TextField(
                    onChanged: (val) {
                      task.setInput(val);
                    },
                    minLines: 1,
                    maxLines: 7,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "напішыце перавод...",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
