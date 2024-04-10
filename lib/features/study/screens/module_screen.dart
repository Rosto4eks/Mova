import "package:flutter/material.dart";
import "package:mova/features/study/providers/module_provider.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/features/study/widgets/lesson_template.dart";
import "package:mova/presentation/components/appbar.dart";
import "package:mova/presentation/components/colors.dart";
import "package:provider/provider.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class ModuleScreen extends StatelessWidget {
  final int moduleIndex;
  const ModuleScreen(this.moduleIndex, {super.key});

  @override
  Widget build(BuildContext context) {
    var study = Provider.of<StudyProvider>(context);
    var module = study.getModule(moduleIndex);
    var pageController = PageController(
      viewportFraction: 0.8,
      initialPage: study.getCurrentLesson(),
    );
    Provider.of<LessonProvider>(context, listen: false).index =
        study.getCurrentLesson();
    return Scaffold(
      appBar: MAppBar(
        module.name,
        175,
        arrow: true,
      ),
      backgroundColor: color1,
      body: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) =>
                    Provider.of<LessonProvider>(context, listen: false)
                        .setIndex(index),
                children: List<LessonTemplate>.generate(
                    module.elementsCount, (index) => LessonTemplate(index)),
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: module.elementsCount,
              effect: const ExpandingDotsEffect(
                  activeDotColor: lightPurple, dotHeight: 16, dotWidth: 16),
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.decelerate),
            )
          ],
        ),
      ),
    );
  }
}
