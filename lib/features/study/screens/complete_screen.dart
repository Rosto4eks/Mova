import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/features/study/screens/lesson_screen.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class CompleteScreen extends StatelessWidget {
  final Lesson lesson;
  final int lessonIndex;
  const CompleteScreen(this.lesson, this.lessonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomLeft,
            radius: 1.5,
            colors: [
              lightBlue,
              lightGrey,
            ],
          ),
        ),
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 70, bottom: 10),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: lesson.elementsCompleted.toDouble() /
                  lesson.elementsCount.toDouble(),
              color: const Color.fromARGB(255, 123, 248, 161),
              minHeight: 7,
              borderRadius: BorderRadius.circular(15),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Text(
                      lesson.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: const Text(
                      "Занятак пройдзен!",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Image.asset(
                    "assets/images/sigma.gif",
                    height: 400,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<StudyProvider>(context, listen: false)
                          .resetTasks();
                      Provider.of<StudyProvider>(context, listen: false)
                          .refresh();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => LessonScreen(lessonIndex),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 40, bottom: 10),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const Text(
                        "перапрайсці",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: black),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 40, top: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(55),
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 8), // changes position of shadow
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const Text(
                        "далей",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
