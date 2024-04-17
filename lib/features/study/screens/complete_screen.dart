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
        color: color4,
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
            Container(
              margin: const EdgeInsets.all(20),
              child: const Text(
                "Занятак пройдзен!",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.width / 2,
                alignment: Alignment.center,
                child: Image.asset("assets/images/alesya-3.png"),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                        color: black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: const Text(
                        "далей",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: white),
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
