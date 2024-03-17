import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/features/study/screens/module_screen.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class ModuleTemplate extends StatelessWidget {
  final int moduleIndex;
  const ModuleTemplate(this.moduleIndex, {super.key});

  void openModule(context) {
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (ctx) => ModuleScreen(moduleIndex),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var module = Provider.of<StudyProvider>(context).getModule(moduleIndex);
    var isEnabled =
        Provider.of<StudyProvider>(context).isModuleEnabled(moduleIndex);
    return Container(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: isEnabled
            ? () {
                Provider.of<StudyProvider>(context, listen: false)
                    .selectModule(moduleIndex);
                openModule(context);
              }
            : () {},
        child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isEnabled ? lightBlue : grey,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  module.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
                    color: white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: LinearProgressIndicator(
                    value: module.elementsCompleted.toDouble() /
                        module.elementsCount.toDouble(),
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(20),
                    color: lightGreen,
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      isEnabled
                          ? switch (module.elementsCompleted) {
                              (0) => "пачаць",
                              _ => "працягнуць"
                            }
                          : "закрыта",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
