import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mova/presentation/components/colors.dart';

class NavBar extends StatelessWidget {
  final void Function(int) onTabChange;
  const NavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.05),
            spreadRadius: 4,
            blurRadius: 10,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: GNav(
        duration: const Duration(milliseconds: 350),
        onTabChange: (val) => onTabChange(val),
        activeColor: white,
        tabBackgroundColor: color4,
        color: const Color.fromARGB(255, 191, 207, 202),
        padding: const EdgeInsets.all(10),
        iconSize: 30,
        tabs: const [
          GButton(
            icon: Icons.home_rounded,
          ),
          GButton(
            icon: Icons.translate_rounded,
          ),
          GButton(
            icon: Icons.star_rounded,
          ),
          GButton(
            icon: Icons.bookmark_rounded,
          ),
          GButton(
            icon: Icons.person_rounded,
          ),
        ],
      ),
    );
  }
}
