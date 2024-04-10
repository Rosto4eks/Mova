import 'package:flutter/material.dart';
import 'package:mova/features/study/components/task_buttons.dart';
import 'package:mova/features/study/components/task_componetns.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class WriteTranslationTaskScreen extends StatelessWidget {
  const WriteTranslationTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var task =
        Provider.of<StudyProvider>(context).getTask() as WriteTranslationTask;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            "Перакладзіце тэкст",
            style: TextStyle(
              fontSize: 30,
              color: black,
              fontWeight: FontWeight.bold,
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
                style: const TextStyle(
                  fontSize: 30,
                  color: black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: TextField(
                    autofocus: true,
                    onChanged: (val) {
                      task.setInput(val);
                    },
                    minLines: 1,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    cursorColor: black,
                    style: const TextStyle(
                      fontSize: 22,
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      fillColor: black,
                      border: const UnderlineInputBorder(),
                      focusedBorder: const UnderlineInputBorder(),
                      enabledBorder: const UnderlineInputBorder(),
                      hintText: "напішыце перавод...",
                      hintStyle: TextStyle(color: black.withOpacity(0.4)),
                      contentPadding: const EdgeInsets.all(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
