import "package:flutter/material.dart";
import "package:mova/features/study/providers/study_provider.dart";
import "package:mova/features/users/providers/user_provider.dart";
import "package:mova/features/users/screens/sign_in_page.dart";
import "package:mova/features/users/screens/sign_up_page.dart";
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
    if (!provider.isSignedIn()) {
      return provider.logType == "sign-in" ? SignInPage() : SignUpPage();
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          GestureDetector(
            onTap: () => provider.logout(),
            child: Container(
              child: Text("выйсці"),
            ),
          ),
          GestureDetector(
            onTap: () => study.clear(),
            child: Container(
              child: Text("па новай"),
            ),
          ),
        ]),
      ),
    );
  }
}
