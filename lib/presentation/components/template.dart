import 'package:flutter/material.dart';
import 'package:mova/presentation/components/navBar.dart';

class Template extends StatefulWidget {
  final Widget _topWidget;
  final Widget _bottomWidget;
  const Template(this._topWidget, this._bottomWidget, {super.key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color.fromRGBO(124, 122, 243, 1), Colors.black],
          stops: [0.5, 1],
        )),
        child: Column(children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30))),
            child: widget._topWidget,
          )),
          Expanded(child: widget._bottomWidget),
        ]));
  }
}
