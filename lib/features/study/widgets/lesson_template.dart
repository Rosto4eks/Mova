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
              color: lesson.everCompleted
                  ? const Color.fromARGB(255, 123, 248, 161)
                  : white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      lesson.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: isEnabled ? black : grey,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Nunito"),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "${lesson.elementsCompleted}/${lesson.elementsCount}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: lesson.everCompleted ? white : grey,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
