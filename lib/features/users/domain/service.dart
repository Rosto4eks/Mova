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

  void changeName(String name) {
    if (name.isEmpty) {
      throw Exception("cat be empty");
    }
    Service.user._name = name;
    _repository.saveUser(Service.user);
    _repository.localSaveUser(Service.user);
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

  Future<User> getUsersById(int id) async {
    return await _repository.getUserById(id);
  }

  Future signUp(String email, String password, String name) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      throw Exception("fill all fields");
    }
    if (password.length < 8) {
      throw Exception("too short password");
    }
    if ((await _repository.getUserByEmail(email)).id == -1) {
      var id = await _repository.getNewId();
      User user = User(id, "user", name, email, _hash(password), 0, [], []);
      await _repository.saveUser(user);
      _repository.localSaveUser(user);
      Service.user = user;
    } else {
      throw Exception("user with this email aready registered");
    }
  }

  Future signIn(String email, String password) async {
    User user;
    if (email.isEmpty || password.isEmpty) {
      throw Exception("fill all fields");
    }
    if (password.length < 8) {
      throw Exception("too short password");
    }
    try {
      user = await _repository.getUserByEmail(email);
    } catch (e) {
      throw Exception("User not found");
    }
    if (_hash(password) == user._password) {
      await _repository.saveUser(user);
      _repository.localSaveUser(user);
      Service.user = user;
    } else {
      throw Exception("Invalid password");
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
