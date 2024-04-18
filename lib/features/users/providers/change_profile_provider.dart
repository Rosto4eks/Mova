import 'package:flutter/material.dart';

class ChangeProfileProvider extends ChangeNotifier {
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

  ChangeProfileProvider init(String name) {
    if (_name == "") {
      _name = name;
    }
    return this;
  }
}
