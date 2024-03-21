import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/presentation/components/colors.dart';

class MAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String title;
  final double barHeight = 50.0;
  final bool arrow;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const MAppBar(this.title, this.height, {this.arrow = false, super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            if (arrow)
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                ),
              ),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}
