import 'package:flutter/material.dart';
import 'package:mova/presentation/components/colors.dart';

var checkButton = Container(
  height: 50,
  margin: const EdgeInsets.only(left: 15),
  decoration: BoxDecoration(
    color: white,
    borderRadius: BorderRadius.circular(65),
    boxShadow: [
      BoxShadow(
        color: black.withOpacity(0.1),
        spreadRadius: 1,
        blurRadius: 10,
        offset: const Offset(0, 8), // changes position of shadow
      ),
    ],
  ),
  alignment: Alignment.center,
  child: const Text(
    "праверыць",
    style: TextStyle(
      color: purple,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
  ),
);

var returnButton = Container(
  height: 60,
  margin: const EdgeInsets.all(5),
  alignment: Alignment.center,
  child: const Text(
    "назад",
    style: TextStyle(
      color: white,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
);
