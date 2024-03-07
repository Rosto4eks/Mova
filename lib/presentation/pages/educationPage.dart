import "package:flutter/material.dart";
import "package:mova/presentation/components/template.dart";

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationState();
}

class _EducationState extends State<EducationPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Template(
          Center(
            child: Text("EDUCATION"),
          ),
          Center(
            child: Text("3"),
          )),
    );
  }
}
