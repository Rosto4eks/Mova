import 'package:flutter/material.dart';
import 'package:mova/presentation/components/colors.dart';

class HomeTemplate extends StatelessWidget {
  final Widget _topWidget;
  final Widget _bottomWidget;
  const HomeTemplate(this._topWidget, this._bottomWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 100),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            lightBlue,
            lightGreen.withOpacity(0.6),
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
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: _bottomWidget,
          )),
        ]));
  }
}
