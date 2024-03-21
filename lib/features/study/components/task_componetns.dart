import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

void checkTask(BuildContext context, bool complete) {
  var player = AudioPlayer();
  player.play(AssetSource(complete ? 'sounds/correct.wav' : "sounds/fail.mp3"));
  showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) => Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: complete ? lightGreen : lightRed,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Text(
                    complete ? "Верна!" : "Няверна!",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (complete) {
                          Provider.of<StudyProvider>(context, listen: false)
                              .refresh();
                        }
                        Navigator.of(context).pop();
                      },
                      child: nextButton(complete),
                    ),
                  )
                ],
              ),
            ),
          ));
}

Container nextButton(bool complete) => Container(
      margin: const EdgeInsets.only(left: 15, top: 40, bottom: 40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(55),
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 8), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        complete ? "далей" : "яшчэ раз",
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: black),
      ),
    );
