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
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: isEnabled
            ? () {
                Provider.of<StudyProvider>(context, listen: false)
                    .selectModule(moduleIndex);
                openModule(context);
              }
            : () {},
        child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      module.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 30,
                        color: black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 30),
                      child: LinearProgressIndicator(
                        value: module.elementsCompleted.toDouble() /
                            module.elementsCount.toDouble(),
                        minHeight: 10,
                        borderRadius: BorderRadius.circular(20),
                        color: lightGreen,
                        backgroundColor: isEnabled
                            ? black.withOpacity(0.15)
                            : Colors.transparent,
                      ),
                    ),
                  ],
                )),
                Container(
                  width: double.infinity,
                  height: 60,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: isEnabled ? white : null,
                    boxShadow: [
                      if (isEnabled)
                        BoxShadow(
                          color: black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 5), // changes position of shadow
                        ),
                    ],
                  ),
                  child: Text(
                    isEnabled
                        ? module.elementsCompleted == 0
                            ? "пачаць"
                            : module.elementsCompleted == module.elementsCount
                                ? "зроблена"
                                : "працягнуць"
                        : "закрыта",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
