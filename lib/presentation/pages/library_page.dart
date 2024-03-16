import "package:flutter/material.dart";
import "package:mova/presentation/components/home_screen_template.dart";

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPage();
}

class _LibraryPage extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeTemplate(
          Center(
            child: Text("LIBRARY"),
          ),
          Center(
            child: Text("4"),
          )),
    );
  }
}
