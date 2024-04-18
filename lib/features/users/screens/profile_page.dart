import "dart:ui";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/service.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/features/users/providers/change_profile_provider.dart";
import "package:mova/features/users/providers/user_provider.dart";
import "package:mova/features/users/screens/change_profile_page.dart";
import "package:mova/features/users/screens/search_user_page.dart";
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
    var changer = Provider.of<ChangeProfileProvider>(context, listen: false);
    var achievements = ["aboba", "bebra", "biba", "cocos", "molokosos"];
    var user = provider.getUser();
    if (!provider.isSignedIn()) {
      return provider.logType == "sign-in" ? SignInPage() : SignUpPage();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: lightGrey,
        padding: EdgeInsets.only(bottom: 100, left: 20, right: 20),
        alignment: Alignment.center,
        child: ListView(children: [
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
                          builder: (context) => ChangeProfilePage(),
                        ));
                  },
                  child: Icon(Icons.edit),
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
                          "${user.gems}",
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
                          "${user.progress}",
                          style: const TextStyle(fontSize: 20, color: black),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                CupertinoPageRoute(builder: (context) => SearchUserPage())),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: black,
                  boxShadow: [
                    BoxShadow(
                      color: black.withOpacity(0.05),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.circular(15)),
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "знайсці карыстальніка",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: white),
                  ),
                  Icon(
                    Icons.search,
                    color: white,
                  )
                ],
              ),
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
              "Пошта:   ${user.email}",
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
              "Роля:   ${user.role}",
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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: achievements.length,
                itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                          gradient: const RadialGradient(
                              colors: [color4, lightGrey],
                              radius: 2,
                              center: Alignment.topRight),
                          borderRadius: BorderRadius.circular(15)),
                      margin: const EdgeInsets.symmetric(
                          vertical: 30, horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      child: Text(
                        achievements[index],
                        style: TextStyle(color: color6, fontSize: 20),
                      ),
                    )),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => provider.logout(),
                  child: const Text(
                    "выйсці",
                    style: TextStyle(
                        color: Color.fromARGB(255, 236, 120, 112),
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Service.user.resetProgress();
                    study.clear();
                  },
                  child: const Text(
                    "па новай",
                    style: TextStyle(
                        color: Color.fromARGB(255, 236, 120, 112),
                        fontSize: 20,
                        fontWeight: FontWeight.w900),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
