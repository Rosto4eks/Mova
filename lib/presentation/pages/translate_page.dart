import "package:flutter/material.dart";
import "package:mova/presentation/components/home_screen_template.dart";

class TranslatePage extends StatefulWidget {
  const TranslatePage({super.key});

  @override
  State<TranslatePage> createState() => _TranslateState();
}

class _TranslateState extends State<TranslatePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeTemplate(
          Center(
            child: Text("TRANSLATE"),
          ),
          Center(
            child: Text("2"),
          )),
    );
  }
}
