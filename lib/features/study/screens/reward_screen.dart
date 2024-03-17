import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/study/domain/usecase/study.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/features/study/screens/complete_screen.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class RewardScreen extends StatelessWidget {
  final Lesson lesson;
  final int lessonIndex;
  const RewardScreen(this.lesson, this.lessonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    AudioPlayer().play(AssetSource("sounds/complete.mp3"), volume: 0.6);
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
                      "228",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      "assets/images/sigma.gif",
                      height: 400,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (ctx) => CompleteScreen(lesson, lessonIndex),
                      ),
                    ),
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
