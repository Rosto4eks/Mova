import 'package:flutter/material.dart';

class ChangeUserProvider extends ChangeNotifier {
  var _name = "";
  var _error = "";

  String get name => _name;
  String get error => _error;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void clear() {
    _name = "";
    _error = "";
  }
}
