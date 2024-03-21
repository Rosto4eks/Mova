import 'package:flutter/material.dart';
import 'package:mova/presentation/components/colors.dart';

class HomeTemplate extends StatelessWidget {
  final Widget _topWidget;
  final Widget _bottomWidget;
  const HomeTemplate(this._topWidget, this._bottomWidget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(bottom: 100),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            purple,
            lightPurple,
          ],
        )),
        child: Column(children: [
          Expanded(
            child: _topWidget,
          ),
          Expanded(
            child: _bottomWidget,
          ),
        ]));
  }
}
