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
            margin: const EdgeInsets.only(
                top: 100, left: 20, right: 20, bottom: 15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      module.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        color: isEnabled ? black : black.withOpacity(0.3),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 300,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.asset(
                        "assets/images/${module.name}.png",
                        color: isEnabled ? color4 : grey,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 30),
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
                ),
                Container(
                  width: double.infinity,
                  height: 60,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: isEnabled ? black : null,
                    boxShadow: [
                      if (isEnabled)
                        BoxShadow(
                          color: black.withOpacity(0.05),
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
                            : "працягнуць"
                        : "закрыта",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: isEnabled ? white : black.withOpacity(0.6),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
