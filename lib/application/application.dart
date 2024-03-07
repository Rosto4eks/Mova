import 'package:flutter/material.dart';
import 'package:mova/presentation/pages/mainPage.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mova",
      home: MainPage(),
    );
  }
}
