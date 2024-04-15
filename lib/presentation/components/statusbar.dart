import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class StatusBar extends StatelessWidget implements PreferredSizeWidget {
  final double height = 40.0;

  @override
  Size get preferredSize => Size.fromHeight(height);

  const StatusBar({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    return PreferredSize(
      preferredSize: preferredSize,
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 50, bottom: 10),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
        ),
        width: double.infinity,
        height: height,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 5),
              child: Image.asset(
                "assets/images/coin.png",
                height: 30,
              ),
            ),
            Container(
              child: Text(
                "${provider.getUser().gems}",
                style: TextStyle(
                  color: Color.fromARGB(255, 147, 173, 243),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
