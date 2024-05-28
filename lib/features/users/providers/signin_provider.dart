import 'package:flutter/material.dart';

class SigninProvider extends ChangeNotifier {
  var _email = "";
  var _password = "";
  var _emailError = "";
  var _passwordError = "";

  String get email => _email;
  String get password => _password;
  String get emailError => _emailError;
  String get passwordError => _passwordError;

  void setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    _password = password;
    notifyListeners();
  }

  void setError(List<String> errors) {
    _emailError = "";
    _passwordError = "";
    for (var error in errors) {
      if (error == "няма злучэння") {
        _emailError = error;
      }
      if (error == "даўжыня пошты павінна быць больш за 7") {
        _emailError = error;
      }
      if (error == "даўжыня пароля павінна быць больш за 8") {
        _passwordError = error;
      }
      if (error == "карыстальнік з гэтай поштай не знойдзены") {
        _emailError = error;
      }
      if (error == "няправільны пароль") {
        _passwordError = error;
      }
    }
    notifyListeners();
  }

  void clear() {
    _email = "";
    _password = "";
    _passwordError = "";
    _emailError = "";
  }
}

class SignupProvider extends ChangeNotifier {
  var _name = "";
  var _email = "";
  var _password = "";
  var _nameError = "";
  var _emailError = "";
  var _passwordError = "";

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get nameError => _nameError;
  String get emailError => _emailError;
  String get passwordError => _passwordError;

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

  void setError(List<String> errors) {
    _nameError = "";
    _emailError = "";
    _passwordError = "";
    for (var error in errors) {
      if (error == "няма злучэння") {
        _nameError = error;
      }
      if (error == "даўжыня імя павінна быць больш за 5") {
        _nameError = error;
      }
      if (error == "даўжыня пошты павінна быць больш за 7") {
        _emailError = error;
      }
      if (error == "даўжыня пароля павінна быць больш за 8") {
        _passwordError = error;
      }
      if (error == "карыстальнік з гэтай поштай ужо зарэгістраваны") {
        _emailError = error;
      }
    }
    notifyListeners();
  }

  void clear() {
    _name = "";
    _email = "";
    _password = "";
    _nameError = "";
    _emailError = "";
    _passwordError = "";
  }
}
