import "package:flutter/material.dart";
import "package:mova/presentation/components/template.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Template(
          Center(
            child: Text("HOME"),
          ),
          Center(
            child: Text("1"),
          )),
    );
  }
}
