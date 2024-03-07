import 'package:flutter/material.dart';
import 'package:mova/presentation/components/navBar.dart';
import 'package:mova/presentation/pages/educationPage.dart';
import 'package:mova/presentation/pages/homePage.dart';
import 'package:mova/presentation/pages/libraryPage.dart';
import 'package:mova/presentation/pages/profilePage.dart';
import 'package:mova/presentation/pages/translatePage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void navigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const TranslatePage(),
    const EducationPage(),
    const LibraryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(
        onTabChange: (index) => navigate(index),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
