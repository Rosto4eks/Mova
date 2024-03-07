import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatelessWidget {
  final void Function(int) onTabChange;
  const NavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(20),
      child: GNav(
        onTabChange: (val) => onTabChange(val),
        activeColor: const Color.fromRGBO(165, 164, 255, 1),
        color: const Color.fromARGB(255, 50, 43, 82),
        padding: const EdgeInsets.all(5),
        iconSize: 30,
        tabs: const [
          GButton(
            icon: Icons.home,
          ),
          GButton(
            icon: Icons.translate,
          ),
          GButton(
            icon: Icons.book,
          ),
          GButton(
            icon: Icons.archive,
          ),
          GButton(
            icon: Icons.account_circle,
          ),
        ],
      ),
    );
  }
}
