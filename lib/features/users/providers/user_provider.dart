import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mova/features/service.dart';
import 'package:mova/features/users/domain/service.dart';

class UserProvider extends ChangeNotifier {
  final UserService _service;

  String logType = "sign-in";

  UserProvider(this._service);

  int reward() {
    var reward = 30 + Random().nextInt(30);
    _service.addGems(reward);
    return reward;
  }

  bool isSignedIn() {
    return Service.user.id != User.empty.id;
  }

  User getUser() {
    return Service.user;
  }

  Future<String> signUp(String email, String name, String password) async {
    try {
      await _service.signUp(email, password, name);
    } on FormatException catch (e) {
      return e.message;
    }
    return "";
  }

  Future<String> signIn(String email, String password) async {
    try {
      await _service.signIn(email, password);
    } on FormatException catch (e) {
      return e.message;
    }
    return "";
  }

  Future<String> changeName(String name) async {
    try {
      await _service.changeName(name);
    } on FormatException catch (e) {
      return e.message;
    }
    return "";
  }

  void logout() {
    _service.logOut();
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }
}
