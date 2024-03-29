import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mova/presentation/components/colors.dart';

class NavBar extends StatelessWidget {
  final void Function(int) onTabChange;
  const NavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: white,
        boxShadow: [
          BoxShadow(
            color: black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10),
      child: GNav(
        duration: Duration(milliseconds: 350),
        onTabChange: (val) => onTabChange(val),
        activeColor: white,
        tabBackgroundColor: lightPurple,
        color: const Color.fromARGB(255, 191, 207, 202),
        padding: const EdgeInsets.all(10),
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
