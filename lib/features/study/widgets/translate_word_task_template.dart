import 'package:flutter/material.dart';
import 'package:mova/features/study/components/task_componetns.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class TranslateWordTaskTemplate extends StatefulWidget {
  final int lessonIndex;
  TranslateWordTaskTemplate(this.lessonIndex, {super.key});

  @override
  State<TranslateWordTaskTemplate> createState() =>
      _TranslateWordTaskTemplateState();
}

class _TranslateWordTaskTemplateState extends State<TranslateWordTaskTemplate> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var lesson =
        Provider.of<StudyProvider>(context).getLesson(widget.lessonIndex);
    var task =
        Provider.of<StudyProvider>(context).getTask() as TranslateWordTask;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.topLeft,
          child: const Text(
            "Перакладзіце слова",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 35,
              color: color2,
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
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 78, 78, 78)),
          ),
        ),
        Expanded(
            flex: 2,
            child: Container(
                child: ListView.builder(
              itemCount: task.translations.length,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  task.selectTranslation(index);
                  setState(() {
                    selectedIndex = index;
                  });
                  Provider.of<StudyProvider>(context, listen: false).refresh();
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: index == selectedIndex ? color4 : color2,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    task.translations[index],
                    style: TextStyle(color: color3, fontSize: 23),
                  ),
                ),
              ),
            ))),
        GestureDetector(
          onTap: () {
            checkTask(context, task.check());
            selectedIndex = -1;
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
