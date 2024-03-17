import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/study/domain/usecase/study.dart";
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
          Center(
            child: Text(
              "хатняя",
              style: TextStyle(color: white, fontSize: 40),
            ),
          ),
          Center(
            child: Center(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                      decoration: BoxDecoration(
                          color: white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 189, 189, 189)
                                  .withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              _prevBook,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            const Text(
                              "Чытаць далей",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!allCompleted)
                    Expanded(
                      child: GestureDetector(
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
                          margin: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          decoration: BoxDecoration(
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 189, 189, 189)
                                      .withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: Container(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  lesson.name,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(20),
                                  child: LinearProgressIndicator(
                                    value: lesson.elementsCompleted.toDouble() /
                                        lesson.elementsCount.toDouble(),
                                    minHeight: 8,
                                    borderRadius: BorderRadius.circular(30),
                                    color: blue,
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
                      ),
                    ),
                ],
              ),
            ),
          )),
    );
  }
}
