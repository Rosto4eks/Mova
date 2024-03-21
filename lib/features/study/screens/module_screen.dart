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
      initialPage: () {
        var i = study.getCurrentLesson();
        return i;
      }(),
    );
    return Scaffold(
      appBar: MAppBar(
        module.name,
        175,
        arrow: true,
      ),
      backgroundColor: lightGrey,
      body: Container(
        padding: EdgeInsets.only(bottom: 20),
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
              effect: ExpandingDotsEffect(
                  activeDotColor: blue.withOpacity(0.5),
                  dotHeight: 16,
                  dotWidth: 16),
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.decelerate),
            )
          ],
        ),
      ),
    );
  }
}
