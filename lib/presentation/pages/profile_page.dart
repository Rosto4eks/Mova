import "package:flutter/material.dart";
import "package:mova/presentation/components/home_screen_template.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeTemplate(
          Center(
            child: Text("PROFILE"),
          ),
          Center(
            child: Text("5"),
          )),
    );
  }
}
