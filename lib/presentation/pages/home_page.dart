import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/presentation/components/colors.dart";
import "package:mova/presentation/components/home_screen_template.dart";
import "package:mova/features/study/screens/study_screen.dart";
import "package:mova/presentation/pages/main_page.dart";

class HomePage extends StatefulWidget {
  PageController _pageController;
  HomePage(this._pageController, {super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  double _moduleProgress = 0.8;
  String _moduleName = "занятак 1 - 3";
  String _prevBook = "Дзікае паляванне караля стаха";

  void _navigateToLesson() {
    widget._pageController.jumpToPage(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeTemplate(
          Center(
            child: Text(
              "HOME",
              style: TextStyle(
                color: color3,
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
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
                          color: color3,
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
                  Expanded(
                    child: GestureDetector(
                      onTap: _navigateToLesson,
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        decoration: BoxDecoration(
                            color: color3,
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
                          padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                _moduleName,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                              Container(
                                margin: const EdgeInsets.all(20),
                                child: LinearProgressIndicator(
                                  value: _moduleProgress,
                                  minHeight: 8,
                                  borderRadius: BorderRadius.circular(30),
                                  color: color4,
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
