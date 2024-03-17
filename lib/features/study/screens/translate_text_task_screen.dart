import 'package:flutter/material.dart';
import 'package:mova/features/study/components/task_buttons.dart';
import 'package:mova/features/study/components/task_componetns.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class TranslateTextTaskScreen extends StatelessWidget {
  const TranslateTextTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              fontSize: 30,
              color: black,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
          child: Text(
            task.text,
            style: const TextStyle(fontSize: 25),
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: black,
        ),
        GestureDetector(
          onTap: () {
            task.removeLast();
            Provider.of<StudyProvider>(context, listen: false).refresh();
          },
          child: Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
            child: Text(
              task.translation,
              style: const TextStyle(fontSize: 25),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.only(bottom: 100),
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
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 15,
                                offset:
                                    Offset(0, 8), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Text(
                            e,
                            style: TextStyle(color: black, fontSize: 23),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: returnButton,
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  checkTask(context, task.check());
                },
                child: checkButton,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
