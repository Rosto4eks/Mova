import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/presentation/components/colors.dart";
import "package:mova/features/study/widgets/module_template.dart";
import "package:provider/provider.dart";

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyState();
}

class _StudyState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: color2,
          toolbarHeight: 100,
          flexibleSpace: Container(
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            alignment: Alignment.bottomLeft,
            child: const Text("Модулі",
                style: TextStyle(
                  color: color3,
                  fontWeight: FontWeight.bold,
                  fontSize: 45,
                )),
          ),
        ),
        body: Consumer<StudyProvider>(
          builder: (context, study, child) {
            return PageView(
                scrollDirection: Axis.vertical,
                controller: PageController(viewportFraction: 0.7),
                children: List<ModuleTemplate>.generate(
                    study.getModulesCount(), (index) => ModuleTemplate(index)));
          },
        ));
  }
}
