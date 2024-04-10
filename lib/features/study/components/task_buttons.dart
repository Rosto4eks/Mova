import 'package:flutter/material.dart';
import 'package:mova/presentation/components/colors.dart';

var checkButton = Container(
  height: 60,
  margin: const EdgeInsets.only(left: 15),
  decoration: BoxDecoration(
    color: black,
    borderRadius: BorderRadius.circular(20),
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
      color: white,
      fontWeight: FontWeight.bold,
      fontSize: 21,
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
      color: black,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  ),
);
