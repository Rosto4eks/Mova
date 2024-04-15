import 'package:flutter/material.dart';

class SigninProvider extends ChangeNotifier {
  var _email = "";
  var _password = "";
  var _error = "";

  String get email => _email;
  String get password => _password;
  String get error => _error;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void clear() {
    _email = "";
    _password = "";
    _error = "";
  }
}

class SignupProvider extends ChangeNotifier {
  var _name = "";
  var _email = "";
  var _password = "";
  var _error = "";

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get error => _error;

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void clear() {
    _name = "";
    _email = "";
    _password = "";
    _error = "";
  }
}
