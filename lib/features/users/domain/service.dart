import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mova/features/service.dart';
import 'package:mova/features/users/repository/dto.dart';
import 'package:mova/presentation/components/colors.dart';
import 'package:overlay_support/overlay_support.dart';

part "user.dart";
part "../repository/repository.dart";

Map<int, String> achievements = {
  0: "выпаўнена 10 заданняў",
  1: "выпаўнена 20 заданняў",
  2: "выпаўнена 30 заданняў",
  3: "выпаўнена 40 заданняў",
  4: "выпаўнена 50 заданняў",
  5: "зароблена 300 крышталаў",
  6: "зароблена 500 крышталаў",
  7: "зароблена 1000 крышталаў",
  8: "зароблена 5000 крышталаў",
  9: "зароблена 10000 крышталаў"
};

class UserService extends Service {
  late final UserRepository _repository;

  UserService(this._repository) {
    Service.user = _repository.loadUser();
  }

  Future changeName(String name) async {
    if (name.length < 5) {
      throw const FormatException("даўжыня імя павінна быць больш за 6");
    }
    Service.user._name = name;
    await _repository.saveUser(Service.user);
    _repository.localSaveUser(Service.user);
  }

  Future adminChangeUser(
    User user,
    int gems,
    int tasks,
    String role,
  ) async {
    if (Service.user.role != "admin") {
      throw const FormatException("Няма праў");
    }
    if (gems < 0) {
      throw const FormatException("колькасць крышталаў павінна быць станоўчым");
    }
    if (tasks < 0) {
      throw const FormatException(
          "колькасць выпаўненных заданняў павінна быць станоўчым");
    }
    if (role != "admin" && role != "user") {
      throw const FormatException("няверная роля");
    }
    user._gems = gems;
    user._role = role;
    user._progress = tasks;
    await _repository.saveUser(user);
  }

  void changePassword(String password) {
    Service.user._password = _hash(password);
    _repository.saveUser(Service.user);
    _repository.localSaveUser(Service.user);
  }

  void addGems(int gems) {
    Service.user._gems += gems;

    if (Service.user.id != -1) {
      if (Service.user._gems >= 300) {
        if (!Service.user.achievements.contains(5)) {
          Service.user.achievements.add(5);
          showAchievement("зароблена 300 крышталаў!");
        }
      }

      if (Service.user._gems >= 500) {
        if (!Service.user.achievements.contains(6)) {
          Service.user.achievements.add(6);
          showAchievement("зароблена 500 крышталаў!");
        }
      }

      if (Service.user._gems >= 1000) {
        if (!Service.user.achievements.contains(7)) {
          Service.user.achievements.add(7);
          showAchievement("зароблена 1000 крышталаў!");
        }
      }

      if (Service.user._gems >= 5000) {
        if (!Service.user.achievements.contains(8)) {
          Service.user.achievements.add(8);
          showAchievement("зароблена 5000 крышталаў!");
        }
      }

      if (Service.user._gems >= 10000) {
        if (!Service.user.achievements.contains(9)) {
          Service.user.achievements.add(9);
          showAchievement("зароблена 10000 крышталаў!");
        }
      }
    }

    _repository.saveUser(Service.user);
    _repository.localSaveUser(Service.user);
  }

  Future<User?> getUserByName(String name) async {
    return await _repository.getUserByName(name);
  }

  Future<User> getUserById(int id) async {
    return await _repository.getUserById(id);
  }

  Future<List<String>> signUp(
      String email, String password, String name) async {
    List<String> errors = [];
    if (name.length < 5) {
      errors.add("даўжыня імя павінна быць больш за 5");
    }
    if (email.length < 7) {
      errors.add("даўжыня пошты павінна быць больш за 7");
    }
    if (password.length < 8) {
      errors.add("даўжыня пароля павінна быць больш за 8");
    }
    if (errors.isNotEmpty) {
      return errors;
    }
    if ((await _repository.getUserByEmail(email)).id == -1) {
      if ((await _repository.getUserByName(name)) == null) {
        var id = await _repository.getNewId();
        User user = User(id, "user", name, email, _hash(password), 0,
            Service.user._progress, [], []);
        await _repository.saveUser(user);
        _repository.localSaveUser(user);
        Service.user = user;
      } else {
        errors.add('карыстальнік з гэтым іменем існуе');
      }
    } else {
      errors.add("карыстальнік з гэтай поштай існуе");
    }
    return errors;
  }

  Future<List<String>> signIn(String email, String password) async {
    User user;
    List<String> errors = [];
    if (email.length < 7) {
      errors.add("даўжыня пошты павінна быць больш за 7");
    }
    if (password.length < 8) {
      errors.add("даўжыня пароля павінна быць больш за 8");
    }
    if (errors.isNotEmpty) {
      return errors;
    }
    user = await _repository.getUserByEmail(email);
    if (user.id == -1) {
      errors.add("карыстальнік з гэтай поштай не знойдзены");
    }
    if (errors.isNotEmpty) {
      return errors;
    }
    if (_hash(password) == user._password) {
      _repository.localSaveUser(user);
      Service.user = user;
    } else {
      errors.add("няправільны пароль");
    }
    return errors;
  }

  Future logOut() async {
    Service.user = User.empty;
    _repository.localSaveUser(User.empty);
  }

  User showUser() {
    return Service.user;
  }

  String _hash(String str) {
    return sha256.convert(utf8.encode(str)).toString();
  }

  void showAchievement(String text) {
    showOverlayNotification((context) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(fontSize: 18, color: black),
              ),
              const Icon(
                Icons.star_rounded,
                color: lightGreen,
              )
            ],
          ),
        ),
      );
    }, duration: const Duration(seconds: 2));
  }
}
