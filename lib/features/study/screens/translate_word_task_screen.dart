import 'package:flutter/material.dart';
import 'package:mova/features/study/components/task_buttons.dart';
import 'package:mova/features/study/components/task_componetns.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class TranslateWordTaskScreen extends StatefulWidget {
  const TranslateWordTaskScreen({super.key});

  @override
  State<TranslateWordTaskScreen> createState() =>
      _TranslateWordTaskScreenState();
}

class _TranslateWordTaskScreenState extends State<TranslateWordTaskScreen> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var task =
        Provider.of<StudyProvider>(context).getTask() as TranslateWordTask;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            "Перакладзіце слова",
            style: TextStyle(
              fontSize: 25,
              color: black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
          child: Text(
            task.word,
            style: const TextStyle(
              fontSize: 30,
              color: black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: GridView.count(
            mainAxisSpacing: 40,
            crossAxisSpacing: 40,
            crossAxisCount: 2,
            children: List.generate(
              4,
              (index) => GestureDetector(
                onTap: () {
                  task.selectTranslation(index);
                  setState(() {
                    selectedIndex = index;
                  });
                  Provider.of<StudyProvider>(context, listen: false).refresh();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: index == selectedIndex ? white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: index == selectedIndex ? white : black,
                        width: 0.5),
                  ),
                  child: Text(
                    task.translations[index],
                    style: const TextStyle(
                      color: black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
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
                  selectedIndex = -1;
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
