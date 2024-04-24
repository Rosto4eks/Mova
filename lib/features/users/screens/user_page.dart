// ignore_for_file: prefer_const_constructors

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:mova/features/service.dart";
import "package:mova/features/users/domain/service.dart";
import "package:mova/features/users/providers/change_user_provider.dart";
import "package:mova/features/users/screens/change_user_page.dart";
import "package:mova/presentation/components/colors.dart";
import "package:provider/provider.dart";

class UserPage extends StatefulWidget {
  final User user;
  const UserPage(this.user, {super.key});

  @override
  State<UserPage> createState() => _UserState();
}

class _UserState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    var changer = Provider.of<ChangeUserProvider>(context, listen: false);
    var role = Service.user.role;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: lightGrey,
        padding: EdgeInsets.only(bottom: 100, left: 20, right: 20),
        alignment: Alignment.center,
        child: ListView(children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                ),
              ),
              Expanded(
                child: Text(
                  widget.user.name,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (role == "admin") {
                    changer.clear();
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ChangeUserPage(widget.user),
                      ),
                    );
                  }
                },
                child: Icon(
                  Icons.edit,
                  color: role == "admin" ? color6 : lightGrey,
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: const RadialGradient(
                            colors: [lightGreen, lightGrey],
                            radius: 1,
                            center: Alignment.topRight),
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.width * 0.43,
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/coin.png",
                          height: MediaQuery.of(context).size.width * 0.2,
                        ),
                        Text(
                          "${widget.user.gems}",
                          style: const TextStyle(fontSize: 20, color: black),
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        gradient: const RadialGradient(
                            colors: [color1, lightGrey],
                            radius: 1,
                            center: Alignment.topLeft),
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.width * 0.43,
                    width: MediaQuery.of(context).size.width * 0.43,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check,
                          size: MediaQuery.of(context).size.width * 0.2,
                          color: color5,
                        ),
                        Text(
                          "${widget.user.progress}",
                          style: const TextStyle(fontSize: 20, color: black),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
          if (role == "admin")
            Container(
              height: 100,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [color4, lightGrey]),
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "Пошта:   ${widget.user.email}",
                style: const TextStyle(fontSize: 20, color: color6),
              ),
            ),
          Container(
            height: 100,
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(vertical: 20),
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [color4, lightGrey]),
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              "Роля:   ${widget.user.role}",
              style: const TextStyle(fontSize: 20, color: color6),
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "дасягненні:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )),
          Container(
            height: 165,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: PageView.builder(
                controller: PageController(
                  viewportFraction: 0.6,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: widget.user.achievements.length,
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [lightGrey, lightGreen]),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 20),
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Text(
                        "${achievements[widget.user.achievements[index]]}",
                        style: TextStyle(color: black, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    )),
          ),
        ]),
      ),
    );
  }
}
