// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/study/domain/usecase/service.dart';
import 'package:mova/features/study/screens/complete_screen.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class RewardScreen extends StatefulWidget {
  final Lesson lesson;
  final int lessonIndex;
  const RewardScreen(this.lesson, this.lessonIndex, {super.key});

  @override
  State<RewardScreen> createState() => _RewardScreenState();
}

class _RewardScreenState extends State<RewardScreen> {
  var scale = 0.01;
  var reward = 0;
  double topd = 50;
  @override
  Widget build(BuildContext context) {
    if (scale == 0.01) {
      Future.delayed(const Duration(microseconds: 1), () {
        setState(() {
          scale = 1;
          topd = topd == 0 ? 50 : 0;
        });
        reward = Provider.of<UserProvider>(context, listen: false).reward();
        AudioPlayer().play(AssetSource("sounds/complete.mp3"), volume: 0.3);
      });
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: color4,
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 70, bottom: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            LinearProgressIndicator(
              value: widget.lesson.elementsCompleted.toDouble() /
                  widget.lesson.elementsCount.toDouble(),
              color: const Color.fromARGB(255, 123, 248, 161),
              minHeight: 7,
              borderRadius: BorderRadius.circular(15),
            ),
            const Text(
              "зароблена крышталаў:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              textAlign: TextAlign.center,
            ),
            Text(
              "$reward",
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 100,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 300,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedPositioned(
                    duration: Duration(seconds: 2),
                    curve: Curves.easeInOut,
                    top: topd,
                    child: AnimatedScale(
                      scale: scale,
                      curve: Curves.decelerate,
                      duration: Duration(milliseconds: 500),
                      child: Image.asset(
                        "assets/images/coin.png",
                        height: 200,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (ctx) =>
                        CompleteScreen(widget.lesson, widget.lessonIndex),
                  ),
                );
              },
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
