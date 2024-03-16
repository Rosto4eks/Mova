import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/features/study/widgets/lesson_template.dart";
import "package:mova/presentation/components/colors.dart";
import "package:provider/provider.dart";

class ModuleScreen extends StatelessWidget {
  final int moduleIndex;
  const ModuleScreen(this.moduleIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    var module = Provider.of<StudyProvider>(context).getModule(moduleIndex);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: color2,
        toolbarHeight: 250,
        leading: IconButton(
          alignment: Alignment.bottomLeft,
          icon: Icon(
            Icons.arrow_back_ios,
            color: color3,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          alignment: Alignment.bottomLeft,
          child: Text(
            module.name,
            style: const TextStyle(
              color: color3,
              fontWeight: FontWeight.bold,
              fontSize: 45,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 247, 247, 247),
      body: ListView(
        children: List<LessonTemplate>.generate(
            module.elementsCount, (index) => LessonTemplate(index)),
      ),
    );
  }
}
