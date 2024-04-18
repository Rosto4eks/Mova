import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:mova/features/users/providers/change_profile_provider.dart';
import 'package:mova/features/users/providers/user_provider.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:provider/provider.dart';

class ChangeProfilePage extends StatelessWidget {
  const ChangeProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<UserProvider>(context);
    var changer = Provider.of<ChangeProfileProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color3,
      body: Center(
        child: Container(
          height: 500,
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
                    maxLength: 50,
                    onChanged: (val) {
                      changer.setName(val);
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
                      hintText: "імя",
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
                          .changeName(
                        changer.name,
                      )
                          .then(
                        (value) {
                          Navigator.pop(context);
                          if (value == "") {
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
                child: const Text(
                  "назад",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
