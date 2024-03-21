import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/study/providers/module_provider.dart';
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
    var currentIndex = Provider.of<LessonProvider>(context).getIndex();

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
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            height: 400,
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: currentIndex == lessonIndex ? 55 : 5,
              top: currentIndex == lessonIndex ? 5 : 55,
            ),
            decoration: BoxDecoration(
              color: isEnabled ? white : grey.withOpacity(0.4),
              boxShadow: [
                if (isEnabled)
                  BoxShadow(
                    color: black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      lesson.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 27,
                        color: isEnabled ? lightPurple : black.withOpacity(0.2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  child: LinearProgressIndicator(
                    value: lesson.elementsCompleted.toDouble() /
                        lesson.elementsCount.toDouble(),
                    color: lightGreen,
                    minHeight: 7,
                    borderRadius: BorderRadius.circular(15),
                    backgroundColor:
                        isEnabled ? grey.withOpacity(0.5) : Colors.transparent,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "${lesson.elementsCompleted}/${lesson.elementsCount}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: isEnabled ? black : black.withOpacity(0.5),
                    ),
                  ),
                ),
                if (isEnabled)
                  Expanded(
                      child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: const EdgeInsets.all(30),
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: lightPurple,
                      ),
                      child: const Text(
                        "перайсці",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: white,
                        ),
                      ),
                    ),
                  ))
              ],
            )),
      ),
    );
  }
}
