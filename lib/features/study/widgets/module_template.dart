import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/study/providers/module_provider.dart';
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
    int activeIndex = Provider.of<ModuleProvider>(context).index;
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
        child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            margin: moduleIndex == activeIndex
                ? EdgeInsets.symmetric(vertical: 55, horizontal: 0)
                : EdgeInsets.symmetric(vertical: 65, horizontal: 15),
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: moduleIndex == activeIndex
                  ? isEnabled
                      ? lightBlue.withOpacity(0.8)
                      : const Color.fromARGB(255, 241, 241, 241)
                  : lightBlue.withOpacity(0.4),
              boxShadow: [
                BoxShadow(
                  color: grey.withOpacity(0.6),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  module.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    color: isEnabled ? white : grey,
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
                    backgroundColor: isEnabled ? white : Colors.transparent,
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
                          ? module.elementsCompleted == 0
                              ? "пачаць"
                              : module.elementsCompleted == module.elementsCount
                                  ? "зроблена"
                                  : "працягнуць"
                          : "закрыта",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isEnabled ? white : grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
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
