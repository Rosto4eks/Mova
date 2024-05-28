// ignore_for_file: prefer_const_constructors

import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:mova/features/service.dart";
import "package:mova/features/users/domain/service.dart";
import "package:mova/features/users/providers/change_user_provider.dart";
import "package:mova/features/users/providers/user_provider.dart";
import "package:mova/features/users/screens/change_user_page.dart";
import "package:mova/presentation/components/colors.dart";
import "package:provider/provider.dart";

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserState();
}

class _UserState extends State<UserPage> {
  bool found = true;
  User? user;
  @override
  Widget build(BuildContext context) {
    var changer = Provider.of<ChangeUserProvider>(context, listen: false);
    var provider = Provider.of<UserProvider>(context);
    var role = Service.user.role;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: lightGrey,
        padding: EdgeInsets.only(left: 20, right: 20),
        alignment: Alignment.center,
        child: ListView(children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Material(
                      color: Colors.transparent,
                      child: TextField(
                        maxLength: 20,
                        onSubmitted: (value) async {
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult
                                  .contains(ConnectivityResult.mobile) ||
                              connectivityResult
                                  .contains(ConnectivityResult.wifi)) {
                            showDialog(
                                // ignore: use_build_context_synchronously
                                context: context,
                                builder: (context) => const Center(
                                      child: CircularProgressIndicator(
                                        color: lightGreen,
                                      ),
                                    ),
                                barrierDismissible: false);
                            var res = await provider.getUserByName(value);
                            setState(
                              () {
                                user = res;
                                found = user != null;
                              },
                            );
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        },
                        minLines: 1,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        cursorColor: black,
                        style: const TextStyle(
                          fontSize: 22,
                          color: black,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          fillColor: black,
                          border: const UnderlineInputBorder(),
                          focusedBorder: const UnderlineInputBorder(),
                          enabledBorder: const UnderlineInputBorder(),
                          hintText: "пошук",
                          hintStyle: TextStyle(color: black.withOpacity(0.4)),
                          contentPadding: const EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (user != null)
            Row(
              children: [
                Expanded(
                  child: Text(
                    user!.name,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.w700),
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
                          builder: (context) => ChangeUserPage(user!),
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
          if (user != null)
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
                            "${user!.gems}",
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
                            "${user!.progress}",
                            style: const TextStyle(fontSize: 20, color: black),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          if (role == "admin" && user != null)
            Container(
              height: 100,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
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
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "Пошта:   ${user!.email}",
                style: const TextStyle(fontSize: 20, color: color6),
              ),
            ),
          if (user != null)
            Container(
              height: 100,
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              padding: const EdgeInsets.all(10),
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
                  borderRadius: BorderRadius.circular(15)),
              child: Text(
                "Роля:   ${user!.role}",
                style: const TextStyle(fontSize: 20, color: color6),
              ),
            ),
          if (user != null)
            Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "дасягненні:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )),
          if (user != null)
            Container(
              height: 165,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: PageView.builder(
                  controller: PageController(
                    viewportFraction: 0.6,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: user!.achievements.length,
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
                          "${achievements[user!.achievements[index]]}",
                          style: TextStyle(color: black, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                      )),
            ),
          if (!found)
            Center(
              child: Text(
                "карыстальнік не знойдзены",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
        ]),
      ),
    );
  }
}
