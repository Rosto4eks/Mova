import 'package:flutter/material.dart';
import 'package:mova/features/study/components/task_buttons.dart';
import 'package:mova/features/study/components/task_componetns.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class InsertWordsTaskScreen extends StatelessWidget {
  const InsertWordsTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var task = Provider.of<StudyProvider>(context).getTask() as InsertWordsTask;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          child: const Text(
            "Устаўце словы",
            style: TextStyle(
              fontSize: 30,
              color: black,
              fontWeight: FontWeight.bold,
            ),
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
              task.text,
              style: const TextStyle(
                fontSize: 22,
                color: black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 100),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 10,
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
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 25),
                          decoration: BoxDecoration(
                            color: e.value ? black : grey,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 15,
                                offset: const Offset(
                                    0, 8), // changes position of shadow
                              ),
                            ],
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Text(
                              e.key,
                              style: TextStyle(
                                color: e.value ? white : grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
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
