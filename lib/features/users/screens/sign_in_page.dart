import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/study/providers/study_provider.dart';
import 'package:mova/features/users/providers/signin_provider.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    var signin = Provider.of<SigninProvider>(context);
    var study = Provider.of<StudyProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color3,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 110, horizontal: 20),
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Text(
              signin.error,
              style: const TextStyle(
                color: Color.fromARGB(255, 236, 73, 73),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  maxLength: 50,
                  onChanged: (val) {
                    signin.setEmail(val);
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
                    hintText: "пошта",
                    hintStyle: TextStyle(color: black.withOpacity(0.4)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              child: Material(
                color: Colors.transparent,
                child: TextField(
                  maxLength: 30,
                  obscureText: true,
                  onChanged: (val) {
                    signin.setPassword(val);
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
                    hintText: "пароль",
                    hintStyle: TextStyle(color: black.withOpacity(0.4)),
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                onTap: () async {
                  ConnectivityResult connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    showDialog(
                        context: context,
                        builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: lightGreen,
                              ),
                            ),
                        barrierDismissible: false);
                    provider
                        .signIn(
                      signin.email,
                      signin.password,
                    )
                        .then(
                      (value) {
                        Navigator.pop(context);
                        if (value == "") {
                          study.clear();
                          provider.refresh();
                          signin.clear();
                        } else {
                          signin.setError(value);
                        }
                      },
                    );
                  } else {
                    signin.setError("no internet connection");
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: black, borderRadius: BorderRadius.circular(15)),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text(
                    "увайсці",
                    style: TextStyle(fontSize: 20, color: white),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () {
                  signin.clear();
                  provider.logType = "sign-up";
                  provider.refresh();
                },
                child: Text(
                  "рэгістрацыя",
                  style: TextStyle(fontSize: 18, color: black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
