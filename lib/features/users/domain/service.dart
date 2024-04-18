import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import 'package:mova/features/service.dart';
import 'package:mova/features/users/repository/dto.dart';

part "user.dart";
part "achievements.dart";
part "../repository/repository.dart";

class UserService extends Service {
  List<Achievement> _achievements = [];
  late final UserRepository _repository;

  UserService(this._repository) {
    Service.user = _repository.loadUser();
  }

  Future changeName(String name) async {
    if (name.length < 5) {
      throw FormatException("даўжыня імя павінна быць больш за 6");
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
    _repository.saveUser(Service.user);
    _repository.localSaveUser(Service.user);
  }

  List<Achievement> getAchievements() {
    if (_achievements.isEmpty) {
      _achievements =
          _repository.getUserAchievements(Service.user._achievements);
    }
    return _achievements;
  }

  Future<List<User>> getUsersByName(String name) async {
    return await _repository.getUsersByName(name);
  }

  Future<User> getUserById(int id) async {
    return await _repository.getUserById(id);
  }

  Future signUp(String email, String password, String name) async {
    if (name.length < 5) {
      throw const FormatException("даўжыня імя павінна быць больш за 5");
    }
    if (email.length < 7) {
      throw const FormatException("даўжыня пошты павінна быць больш за 7");
    }
    if (password.length < 8) {
      throw const FormatException("даўжыня пароля павінна быць больш за 8");
    }
    if ((await _repository.getUserByEmail(email)).id == -1) {
      var id = await _repository.getNewId();
      User user = User(id, "user", name, email, _hash(password), 0, 0, [], []);
      await _repository.saveUser(user);
      _repository.localSaveUser(user);
      Service.user = user;
    } else {
      throw const FormatException(
          "карыстальнік з гэтай поштай ужо зарэгістраваны");
    }
  }

  Future signIn(String email, String password) async {
    User user;
    if (email.length < 7) {
      throw const FormatException("даўжыня пошты павінна быць больш за 7");
    }
    if (password.length < 8) {
      throw const FormatException("даўжыня пароля павінна быць больш за 8");
    }

    user = await _repository.getUserByEmail(email);
    if (user.id == -1) {
      throw const FormatException("карыстальнік з гэтай поштай не знойдзены");
    }
    if (_hash(password) == user._password) {
      _repository.localSaveUser(user);
      Service.user = user;
    } else {
      throw const FormatException("няправільны пароль");
    }
  }

  void logOut() {
    Service.user = User.empty;
    _repository.localSaveUser(User.empty);
  }

  User showUser() {
    return Service.user;
  }

  String _hash(String str) {
    return sha256.convert(utf8.encode(str)).toString();
  }
}
