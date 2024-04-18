import "package:flutter/material.dart";
import "package:mova/features/study/providers/module_provider.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/presentation/components/colors.dart";
import "package:mova/features/study/widgets/module_template.dart";
import "package:provider/provider.dart";
import "package:smooth_page_indicator/smooth_page_indicator.dart";

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  State<StudyScreen> createState() => _StudyState();
}

class _StudyState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    var study = Provider.of<StudyProvider>(context);
    var count = study.getModulesCount();
    var pageController = PageController(
      viewportFraction: 1,
      initialPage: () {
        var i = study.getCurrentModule();
        return i;
      }(),
    );

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        color: color4,
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) =>
                    Provider.of<ModuleProvider>(context, listen: false)
                        .setIndex(index),
                children: List<ModuleTemplate>.generate(
                  count,
                  (index) => ModuleTemplate(index),
                ),
              ),
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: count,
              effect: const WormEffect(
                  activeDotColor: white,
                  dotColor: grey,
                  dotHeight: 12,
                  dotWidth: 12),
              onDotClicked: (index) {},
            )
          ],
        ),
      ),
    );
  }
}
