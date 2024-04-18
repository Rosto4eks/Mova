import 'package:flutter/material.dart';
import 'package:mova/features/users/domain/service.dart';

class ChangeUserProvider extends ChangeNotifier {
  var _gems = -1;
  var _tasks = -1;
  var _role = "";
  var _error = "";

  int get gems => _gems;
  int get tasks => _tasks;
  String get role => _role;
  String get error => _error;

  void setGems(int? gems) {
    if (gems == null) {
      _gems = 0;
    } else {
      _gems = gems;
    }
    notifyListeners();
  }

  void setTasks(int? tasks) {
    if (tasks == null) {
      _tasks = 0;
    } else {
      _tasks = tasks;
    }
    notifyListeners();
  }

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }

  void setError(String error) {
    _error = error;
    notifyListeners();
  }

  void clear() {
    _gems = 0;
    _role = "";
    _error = "";
  }

  ChangeUserProvider init(User user) {
    if (_gems == -1) {
      _gems = user.gems;
    }
    if (_role == "") {
      _role = user.role;
    }
    if (_tasks == -1) {
      _tasks = user.progress;
    }
    return this;
  }
}
