import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/study/domain/usecase/service.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/features/study/screens/lesson_screen.dart";
import "package:mova/presentation/components/colors.dart";
import "package:mova/presentation/components/home_screen_template.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  PageController _pageController;
  HomePage(this._pageController, {super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  String _prevBook = "Дзікае паляванне караля стаха";

  @override
  Widget build(BuildContext context) {
    late Lesson lesson;
    bool allCompleted = false;
    try {
      lesson = Provider.of<StudyProvider>(context).lastUncompletedLesson();
    } catch (e) {
      allCompleted = true;
    }
    return Scaffold(
      body: HomeTemplate(
          const Center(),
          Center(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: black.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          _prevBook,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                        const Text(
                          "Чытаць далей",
                          style: TextStyle(color: Colors.black, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  if (!allCompleted)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (ctx) => LessonScreen(
                                Provider.of<StudyProvider>(context,
                                        listen: false)
                                    .setLastUncompletedLesson()),
                          ),
                        );
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: white,
                            boxShadow: [
                              BoxShadow(
                                color: black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 10,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              lesson.name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            Container(
                              child: LinearProgressIndicator(
                                value: lesson.elementsCompleted.toDouble() /
                                    lesson.elementsCount.toDouble(),
                                minHeight: 8,
                                borderRadius: BorderRadius.circular(30),
                                color: lightGreen,
                                backgroundColor: grey.withOpacity(0.3),
                              ),
                            ),
                            Text(
                              "Працягнуць",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )),
    );
  }
}
