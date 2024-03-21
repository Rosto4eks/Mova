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
    print(task.words);
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
            style: const TextStyle(fontSize: 22),
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
              style: const TextStyle(fontSize: 22),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(bottom: 100),
              child: Wrap(
                spacing: 10,
                runSpacing: 8,
                children: task.words.entries
                    .map<GestureDetector>(
                      (e) => GestureDetector(
                        onTap: () {
                          if (e.value) {
                            task.insertWord(e.key);
                            Provider.of<StudyProvider>(context, listen: false)
                                .refresh();
                          }
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 10),
                          decoration: BoxDecoration(
                            color: e.value ? white : grey,
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
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 200),
                            child: Text(
                              e.key,
                              style: TextStyle(
                                  color: e.value ? black : grey, fontSize: 20),
                            ),
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
