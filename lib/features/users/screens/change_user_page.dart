import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/users/domain/service.dart';
import 'package:mova/features/users/providers/change_user_provider.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class ChangeUserPage extends StatelessWidget {
  final User user;
  const ChangeUserPage(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    var changer = Provider.of<ChangeUserProvider>(context).init(user);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color3,
      body: Center(
        child: Container(
          height: 700,
          margin: const EdgeInsets.symmetric(vertical: 110, horizontal: 20),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                changer.error,
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
                  child: TextFormField(
                    initialValue: user.role,
                    onChanged: (value) {
                      changer.setRole(value);
                    },
                    maxLength: 10,
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
                      hintText: "роля",
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
                  child: TextFormField(
                    initialValue: user.gems.toString(),
                    onChanged: (val) {
                      changer.setGems(int.tryParse(val));
                    },
                    maxLength: 7,
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
                      hintText: "крышталы",
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
                  child: TextFormField(
                    initialValue: user.progress.toString(),
                    maxLength: 7,
                    onChanged: (val) {
                      changer.setTasks(int.tryParse(val));
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
                      hintText: "выпаўнена",
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
                      provider.AdminChangeUser(
                        user,
                        changer.gems,
                        changer.tasks,
                        changer.role,
                      ).then(
                        (value) {
                          Navigator.pop(context);
                          if (value == "") {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            changer.clear();
                            provider.refresh();
                          } else {
                            changer.setError(value);
                          }
                        },
                      );
                    } else {
                      changer.setError("no internet connection");
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: black, borderRadius: BorderRadius.circular(15)),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Text(
                      "змяніць",
                      style: TextStyle(fontSize: 20, color: white),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  child: Text(
                    "назад",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
