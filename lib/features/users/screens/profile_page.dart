import "dart:ui";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/service.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/features/users/providers/change_provider.dart";
import "package:mova/features/users/providers/user_provider.dart";
import "package:mova/features/users/screens/change_page.dart";
import "package:mova/features/users/screens/sign_in_page.dart";
import "package:mova/features/users/screens/sign_up_page.dart";
import "package:mova/presentation/components/colors.dart";
import "package:provider/provider.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    var study = Provider.of<StudyProvider>(context);
    var changer = Provider.of<ChangeUserProvider>(context, listen: false);
    var achievements = ["aboba", "bebra", "biba", "cocos", "molokosos"];
    var user = provider.getUser();
    if (!provider.isSignedIn()) {
      return provider.logType == "sign-in" ? SignInPage() : SignUpPage();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: [color3, lightGrey],
                radius: 1.5,
                center: Alignment.bottomCenter)),
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        alignment: Alignment.center,
        child: Column(children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.w700),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    changer.clear();
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => ChangeUserPage(),
                        ));
                  },
                  child: Icon(Icons.edit),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: Column(children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: Text(
                  "пошта: ${user.email}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: Text(
                  "крысталаў: ${user.gems}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                width: double.infinity,
                child: Text(
                  "выпаўнена: ${user.progress}",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
            ]),
          ),
          Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "дасягненні:",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              )),
          Container(
            height: 250,
            decoration: BoxDecoration(
                color: white,
                boxShadow: [
                  BoxShadow(
                    color: black.withOpacity(0.05),
                    spreadRadius: 4,
                    blurRadius: 10,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.symmetric(vertical: 20),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: achievements.length,
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          color: color1,
                          borderRadius: BorderRadius.circular(15)),
                      margin: EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                      padding: EdgeInsets.all(10),
                      height: 100,
                      width: 150,
                      alignment: Alignment.center,
                      child: Text(
                        achievements[index],
                        style: TextStyle(color: white, fontSize: 20),
                      ),
                    )),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => provider.logout(),
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(15)),
                    child: const Text(
                      "выйсці",
                      style: TextStyle(color: white, fontSize: 20),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  Service.user.resetProgress();
                  study.clear();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(15)),
                  child: const Text(
                    "па новай",
                    style: TextStyle(color: white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
