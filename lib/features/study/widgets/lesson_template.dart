import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/features/study/screens/lesson_screen.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class LessonTemplate extends StatelessWidget {
  final int lessonIndex;
  const LessonTemplate(this.lessonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    var lesson = Provider.of<StudyProvider>(context).getLesson(lessonIndex);
    var isEnabled =
        Provider.of<StudyProvider>(context).isLessonEnabled(lessonIndex);

    void openLesson(context) {
      Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (ctx) => LessonScreen(lessonIndex),
          ));
    }

    return Container(
      alignment: Alignment.bottomLeft,
      child: GestureDetector(
        onTap: isEnabled
            ? () {
                Provider.of<StudyProvider>(context, listen: false)
                    .selectLesson(lessonIndex);
                openLesson(context);
              }
            : () {},
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 160, 160, 160).withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(30),
                    ),
                    color: lesson.everCompleted
                        ? const Color.fromARGB(255, 127, 206, 129)
                        : isEnabled
                            ? const Color.fromARGB(255, 121, 188, 233)
                            : Colors.white,
                  ),
                  height: 16,
                  width: 16,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                ),
                Text(
                  lesson.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: isEnabled
                        ? color4
                        : const Color.fromARGB(255, 189, 189, 189),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: const EdgeInsets.only(left: 15.0, right: 5),
                    child: Text(
                      "${lesson.elementsCount}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: isEnabled
                            ? color2
                            : const Color.fromARGB(255, 189, 189, 189),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topCenter,
                  child: Icon(
                    Icons.category,
                    color: color2,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
