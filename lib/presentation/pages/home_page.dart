import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:mova/features/study/domain/usecase/service.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/features/study/screens/lesson_screen.dart";
import "package:mova/features/users/providers/user_provider.dart";
import "package:mova/presentation/components/colors.dart";
import "package:mova/presentation/components/navbar.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  final PageController _pageController;
  const HomePage(this._pageController, {super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    late Lesson lesson;
    var userProvider = Provider.of<UserProvider>(context);
    bool allCompleted = false;
    try {
      lesson = Provider.of<StudyProvider>(context).lastUncompletedLesson();
    } catch (e) {
      allCompleted = true;
    }
    return Scaffold(
      body: Container(
        color: lightGrey,
        padding:
            const EdgeInsets.only(top: 50, bottom: 100, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Прывітанне!\n${userProvider.getUser().name}",
                style: const TextStyle(
                    fontSize: 28, color: black, fontWeight: FontWeight.w500),
              ),
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/alesya-1.png",
                  width: 325,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Прадоўжыць",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            allCompleted
                ? Container(
                    height: 100,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient:
                            const LinearGradient(colors: [color4, lightGrey]),
                        borderRadius: BorderRadius.circular(15)),
                    child: const Text(
                      "усё пройдзена",
                      style: TextStyle(fontSize: 22, color: color6),
                    ),
                  )
                : GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LessonScreen(
                          Provider.of<StudyProvider>(context, listen: false)
                              .setLastUncompletedLesson(),
                        ),
                      ),
                    ),
                    child: Container(
                      height: 100,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          gradient:
                              const LinearGradient(colors: [color4, lightGrey]),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            lesson.name,
                            style: const TextStyle(fontSize: 22, color: color6),
                          ),
                          Text(
                            "${lesson.elementsCompleted}/${lesson.elementsCount}",
                            style: const TextStyle(fontSize: 18, color: color6),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: color6,
                          )
                        ],
                      ),
                    ),
                  ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<NavBarProvider>(context, listen: false)
                        .setIndex(3);
                    widget._pageController.jumpToPage(3);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: const RadialGradient(
                            colors: [color4, lightGrey],
                            radius: 1,
                            center: Alignment.topRight),
                        color: white,
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.width * 0.43,
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/book.png",
                          height: MediaQuery.of(context).size.width * 0.3,
                        ),
                        const Text(
                          "чытаць",
                          style: TextStyle(fontSize: 16, color: color6),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      gradient: const RadialGradient(
                          colors: [color4, lightGrey],
                          radius: 1,
                          center: Alignment.topLeft),
                      color: white,
                      borderRadius: BorderRadius.circular(15)),
                  height: MediaQuery.of(context).size.width * 0.43,
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/translate.png",
                        height: MediaQuery.of(context).size.width * 0.3,
                      ),
                      const Text(
                        "перавесці",
                        style: TextStyle(fontSize: 16, color: color6),
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
