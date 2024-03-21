import 'package:flutter/material.dart';

class ModuleProvider extends ChangeNotifier {
  int index;

  ModuleProvider(this.index);

  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  int getIndex() => index;
}

class LessonProvider extends ChangeNotifier {
  int index;

  LessonProvider(this.index);

  void setIndex(int i) {
    index = i;
    notifyListeners();
  }

  int getIndex() => index;
}
