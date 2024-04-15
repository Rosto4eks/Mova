import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/study/screens/complete_screen.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class RewardScreen extends StatelessWidget {
  final Lesson lesson;
  final int lessonIndex;
  const RewardScreen(this.lesson, this.lessonIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    var reward = Provider.of<UserProvider>(context, listen: false).reward();
    AudioPlayer().play(AssetSource("sounds/complete.mp3"), volume: 0.6);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: color1,
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 70, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearProgressIndicator(
              value: lesson.elementsCompleted.toDouble() /
                  lesson.elementsCount.toDouble(),
              color: const Color.fromARGB(255, 123, 248, 161),
              minHeight: 7,
              borderRadius: BorderRadius.circular(15),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Image.asset(
                "assets/images/coin.png",
                height: 200,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "зароблена крышталаў: $reward",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
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
                  color: black,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "далей",
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
