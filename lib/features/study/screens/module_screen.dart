import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/features/study/widgets/lesson_template.dart";
import "package:mova/presentation/components/appbar.dart";
import "package:mova/presentation/components/colors.dart";
import "package:provider/provider.dart";

class ModuleScreen extends StatelessWidget {
  final int moduleIndex;
  const ModuleScreen(this.moduleIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    var module = Provider.of<StudyProvider>(context).getModule(moduleIndex);
    return Scaffold(
      appBar: MAppBar(
        module.name,
        200,
        arrow: true,
      ),
      backgroundColor: lightGrey,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomCenter,
            radius: 1.5,
            colors: [
              lightBlue,
              lightGrey,
            ],
          ),
        ),
        child: ListView(
          children: List<LessonTemplate>.generate(
              module.elementsCount, (index) => LessonTemplate(index)),
        ),
      ),
    );
  }
}
