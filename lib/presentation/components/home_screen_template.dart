import 'package:flutter/material.dart';
import 'package:mova/presentation/components/colors.dart';

class HomeTemplate extends StatelessWidget {
  final Widget _topWidget;
  final Widget _bottomWidget;
  const HomeTemplate(this._topWidget, this._bottomWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            lightBlue,
            lightGreen,
          ],
          stops: [0, 0.75],
        )),
        child: Column(children: [
          Expanded(
            child: _topWidget,
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: _bottomWidget,
          )),
        ]));
  }
}
