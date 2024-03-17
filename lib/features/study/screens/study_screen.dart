import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/study/providers/module_provider.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/presentation/components/appbar.dart";
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
        appBar: const MAppBar("Модулі", 150),
        body: Consumer<StudyProvider>(
          builder: (context, study, child) {
            return PageView(
              controller: PageController(
                viewportFraction: 0.75,
                initialPage: () {
                  var i = study.getCurrentModule();
                  Provider.of<ModuleProvider>(context, listen: false).index = i;
                  return i;
                }(),
              ),
              onPageChanged: (index) =>
                  Provider.of<ModuleProvider>(context, listen: false)
                      .setIndex(index),
              children: List<ModuleTemplate>.generate(
                study.getModulesCount(),
                (index) => ModuleTemplate(index),
              ),
            );
          },
        ));
  }
}
