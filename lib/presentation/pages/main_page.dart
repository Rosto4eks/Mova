import 'package:flutter/material.dart';
import 'package:mova/presentation/components/navbar.dart';
import 'package:mova/features/study/screens/study_screen.dart';
import 'package:mova/presentation/pages/home_page.dart';
import 'package:mova/presentation/pages/library_page.dart';
import 'package:mova/presentation/pages/profile_page.dart';
import 'package:mova/presentation/pages/translate_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();

  void navigate(int index) {
    setState(() {
      _pageController.jumpToPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      bottomNavigationBar: NavBar(
        onTabChange: (index) => navigate(index),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          HomePage(_pageController),
          const TranslatePage(),
          const StudyScreen(),
          const LibraryPage(),
          const ProfilePage(),
        ],
      ),
    );
  }
}
