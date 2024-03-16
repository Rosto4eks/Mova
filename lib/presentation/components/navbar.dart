import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mova/presentation/components/colors.dart';

class NavBar extends StatelessWidget {
  final void Function(int) onTabChange;
  const NavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: GNav(
        onTabChange: (val) => onTabChange(val),
        activeColor: color3,
        tabBackgroundColor: color4,
        color: const Color.fromARGB(255, 191, 207, 202),
        padding: const EdgeInsets.all(5),
        iconSize: 30,
        tabs: const [
          GButton(
            icon: Icons.home,
            text: "Хатняя",
          ),
          GButton(
            icon: Icons.translate,
            text: "Перавесці",
          ),
          GButton(
            icon: Icons.book,
            text: "Вучыцца",
          ),
          GButton(
            icon: Icons.archive,
            text: "Архіў",
          ),
          GButton(
            icon: Icons.account_circle,
            text: "Профіль",
          ),
        ],
      ),
    );
  }
}
